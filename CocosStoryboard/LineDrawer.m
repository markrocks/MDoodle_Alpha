/*
 * Smooth drawing: http://merowing.info
 *
 * Copyright (c) 2012 Krzysztof Zabłocki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */
#import <CoreGraphics/CoreGraphics.h>
#import "cocos2d.h"
#import "LineDrawer.h"
#import "CCNode_Private.h" // shader stuff
#import "CCRenderer_private.h" // access to get and stash renderer

typedef struct _LineVertex {
  CGPoint pos;
  float z;
  ccColor4F color;
} LineVertex;

@interface LinePoint : NSObject
@property(nonatomic, assign) CGPoint pos;
@property(nonatomic, assign) float width;
@end


@implementation LinePoint
@synthesize pos;
@synthesize width;
@end

@interface LineDrawer ()

- (void)fillLineTriangles:(LineVertex *)vertices count:(NSUInteger)count withColor:(ccColor4F)color;

- (void)startNewLineFrom:(CGPoint)newPoint withSize:(CGFloat)aSize;

- (void)endLineAt:(CGPoint)aEndPoint withSize:(CGFloat)aSize;

- (void)addPoint:(CGPoint)newPoint withSize:(CGFloat)size;

- (void)drawLines:(NSArray *)linePoints withColor:(ccColor4F)color;

@end

@implementation LineDrawer {
  NSMutableArray *points;
  NSMutableArray *velocities;
  NSMutableArray *circlesPoints;

  BOOL connectingLine;
  CGPoint prevC, prevD;
  CGPoint prevG;
  CGPoint prevI;
  float overdraw;
  ccColor4F penColor;

  CCRenderTexture *renderTexture;
  BOOL finishingLine;
}

- (id)init
{
  
    self = [super init];
  if (self) {
    points = [NSMutableArray array];
    velocities = [NSMutableArray array];
    circlesPoints = [NSMutableArray array];
      
    overdraw = 3.0f;

    CGSize s = [[CCDirector sharedDirector] viewSize];
    renderTexture = [[CCRenderTexture alloc] initWithWidth:s.width height:s.height pixelFormat:CCTexturePixelFormat_RGBA8888];
      /*// ADDED CODE==================>
      //TODO-- INVESTIGATE BLEND MODES
       --Blend modes can acheve different effect -- including color within an area
       --we need to investigat these to see if we can use some of them to create different drawing styles
      
    //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_ONE, GL_ONE_MINUS_SRC_ALPHA}];
      //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_DST_COLOR, GL_SRC_ALPHA}];
      
      
      // Changes colors of items within boundaries if area outside of boundary is white
      //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_ONE_MINUS_SRC_COLOR, GL_ONE_MINUS_SRC_ALPHA}];
      
      //background elements appear in set color - drawing onyl appear on elements in different color
     //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_ONE_MINUS_DST_COLOR, GL_ONE_MINUS_SRC_ALPHA}];
      
      //First working one
       //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_DST_COLOR, GL_ZERO}];
      //Second Working One
      //[[renderTexture sprite] setBlendFunc:(ccBlendFunc){GL_DST_COLOR, GL_SRC_COLOR}];

      // END ADDED CODE==================>*/
      renderTexture.positionType = CCPositionTypeNormalized;
      renderTexture.anchorPoint = ccp(0, 0);
      renderTexture.position = ccp(0.5f, 0.5f);

    
      [renderTexture clear:0.0f g:0.0f b:0.0f a:0.0f];
      
      // the following renders a green line with no background image (original from line drawer )
      //[renderTexture clear:1.0f g:1.0f b:1.0f a:0.0f];
      
      //the following renders a line with a background image ===GOOD
      //[renderTexture clear:0.0f g:0.0f b:0.0f a:0.0f];

      
      //1,1,1,1==white
      //1,1,1,0==white
      //1,1,0,1==yellow
      //1,1,0,0==yellow
      //1,0,1,1==mag
      //1,0,1,0==mag
      //1,0,0,1==red
      //1,0,0,0==red
      
      //0,1,1,1==cyan
      //0,1,1,0==white
      //0,1,0,1==green
      //0,1,0,0==yellow
      //0,0,1,1==blue
      //0,0,1,0==mag
      //0,0,0,1==black
      //0,0,0,0==red

      
    [self addChild:renderTexture];

		[[[CCDirector sharedDirector] view] setUserInteractionEnabled:YES];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:panGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:longPressGestureRecognizer];
    [self registerEventListeners];
      penColor = ccc4f(0.8, 0.0, 0.0, 0.8);
  }
  return self;
}
#pragma mark - Color message listeners
-(void) registerEventListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorPurple" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorBlue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorRed" object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color4" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color5" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color6" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color7" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color8" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color9" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color10" object:nil];
}

-(void)parseNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"colorPurple"]) {
        NSLog(@"purple clicked");
        penColor = ccc4f(0.8, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"colorBlue"]) {
        NSLog(@"blue clicked");
        penColor = ccc4f(0.0, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"colorRed"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.8, 0.0, 0.0, 0.8);
    }
    //
    //
    if ([[notification name] isEqualToString:@"color1"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.8, 0.0, 0.0, 0.8);
    }
    if ([[notification name] isEqualToString:@"color2"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(1.0, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"color3"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.5, 0.0, 1.0, 0.8);
    }
    if ([[notification name] isEqualToString:@"color4"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.16, 0.75, 0.75, 0.8);
    }
    if ([[notification name] isEqualToString:@"color5"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.1, 0.5, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color6"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.45, 0.95, 0.5, 0.8);
    }
    if ([[notification name] isEqualToString:@"color7"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.95, 0.95, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color8"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.95, 0.7, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color9"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.5, 0.5, 0.5, 0.8);
    }
    if ([[notification name] isEqualToString:@"color10"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.0, 0.0, 0.0, 0.8);
    }

}

#pragma mark - Handling points
- (void)startNewLineFrom:(CGPoint)newPoint withSize:(CGFloat)aSize
{
  connectingLine = NO;
  [self addPoint:newPoint withSize:aSize];
}

- (void)endLineAt:(CGPoint)aEndPoint withSize:(CGFloat)aSize
{
  [self addPoint:aEndPoint withSize:aSize];
  finishingLine = YES;
}

- (void)addPoint:(CGPoint)newPoint withSize:(CGFloat)size
{
  LinePoint *point = [[LinePoint alloc] init];
  point.pos = newPoint;
  point.width = size;
  [points addObject:point];
}

#pragma mark - Drawing

#define ADD_TRIANGLE(A, B, C, Z) vertices[index].pos = A, vertices[index++].z = Z, vertices[index].pos = B, vertices[index++].z = Z, vertices[index].pos = C, vertices[index++].z = Z

- (void)drawLines:(NSArray *)linePoints withColor:(ccColor4F)color
{
  unsigned int numberOfVertices = ([linePoints count] - 1) * 18;
  LineVertex *vertices = calloc(sizeof(LineVertex), numberOfVertices);

  CGPoint prevPoint = [(LinePoint *)[linePoints objectAtIndex:0] pos];
  float prevValue = [(LinePoint *)[linePoints objectAtIndex:0] width];
  float curValue;
  int index = 0;
  for (int i = 1; i < [linePoints count]; ++i) {
    LinePoint *pointValue = [linePoints objectAtIndex:i];
    CGPoint curPoint = [pointValue pos];
    curValue = [pointValue width];

    //! equal points, skip them
    if (ccpFuzzyEqual(curPoint, prevPoint, 0.0001f)) {
      continue;
    }

    CGPoint dir = ccpSub(curPoint, prevPoint);
    CGPoint perpendicular = ccpNormalize(ccpPerp(dir));
    CGPoint A = ccpAdd(prevPoint, ccpMult(perpendicular, prevValue / 2));
    CGPoint B = ccpSub(prevPoint, ccpMult(perpendicular, prevValue / 2));
    CGPoint C = ccpAdd(curPoint, ccpMult(perpendicular, curValue / 2));
    CGPoint D = ccpSub(curPoint, ccpMult(perpendicular, curValue / 2));

    //! continuing line
    if (connectingLine || index > 0) {
      A = prevC;
      B = prevD;
    } else if (index == 0) {
      //! circle at start of line, revert direction
      [circlesPoints addObject:pointValue];
      [circlesPoints addObject:[linePoints objectAtIndex:i - 1]];
    }

    ADD_TRIANGLE(A, B, C, 1.0f);
    ADD_TRIANGLE(B, C, D, 1.0f);

    prevD = D;
    prevC = C;
    if (finishingLine && (i == [linePoints count] - 1)) {
      [circlesPoints addObject:[linePoints objectAtIndex:i - 1]];
      [circlesPoints addObject:pointValue];
      finishingLine = NO;
    }
    prevPoint = curPoint;
    prevValue = curValue;

    //! Add overdraw
    CGPoint F = ccpAdd(A, ccpMult(perpendicular, overdraw));
    CGPoint G = ccpAdd(C, ccpMult(perpendicular, overdraw));
    CGPoint H = ccpSub(B, ccpMult(perpendicular, overdraw));
    CGPoint I = ccpSub(D, ccpMult(perpendicular, overdraw));

    //! end vertices of last line are the start of this one, also for the overdraw
    if (connectingLine || index > 6) {
      F = prevG;
      H = prevI;
    }

    prevG = G;
    prevI = I;

    ADD_TRIANGLE(F, A, G, 2.0f);
    ADD_TRIANGLE(A, G, C, 2.0f);
    ADD_TRIANGLE(B, H, D, 2.0f);
    ADD_TRIANGLE(H, D, I, 2.0f);
  }
  [self fillLineTriangles:vertices count:index withColor:color];

  if (index > 0) {
    connectingLine = YES;
  }

  free(vertices);
}

- (void)fillLineEndPointAt:(CGPoint)center direction:(CGPoint)aLineDir radius:(CGFloat)radius andColor:(ccColor4F)color
{
  // Premultiplied alpha.
  color.r *= color.a;
  color.g *= color.a;
  color.b *= color.a;
  ccColor4F fadeOutColor = ccc4f(0, 0, 0, 0);
	
  int numberOfSegments = 32;
  LineVertex *vertices = malloc(sizeof(LineVertex) * numberOfSegments * 9);
  float anglePerSegment = (float)(M_PI / (numberOfSegments - 1));

  //! we need to cover M_PI from this, dot product of normalized vectors is equal to cos angle between them... and if you include rightVec dot you get to know the correct direction :)
  CGPoint perpendicular = ccpPerp(aLineDir);
  float angle = acosf(ccpDot(perpendicular, CGPointMake(0, 1)));
  float rightDot = ccpDot(perpendicular, CGPointMake(1, 0));
  if (rightDot < 0.0f) {
    angle *= -1;
  }

  CGPoint prevPoint = center;
  CGPoint prevDir = ccp(sinf(0), cosf(0));
  for (unsigned int i = 0; i < numberOfSegments; ++i) {
    CGPoint dir = ccp(sinf(angle), cosf(angle));
    CGPoint curPoint = ccp(center.x + radius * dir.x, center.y + radius * dir.y);
    vertices[i * 9 + 0].pos = center;
    vertices[i * 9 + 1].pos = prevPoint;
    vertices[i * 9 + 2].pos = curPoint;

    //! fill rest of vertex data
    for (unsigned int j = 0; j < 9; ++j) {
      vertices[i * 9 + j].z = j < 3 ? 1.0f : 2.0f;
      vertices[i * 9 + j].color = color;
    }

    //! add overdraw
    vertices[i * 9 + 3].pos = ccpAdd(prevPoint, ccpMult(prevDir, overdraw));
    vertices[i * 9 + 3].color = fadeOutColor;
    vertices[i * 9 + 4].pos = prevPoint;
    vertices[i * 9 + 5].pos = ccpAdd(curPoint, ccpMult(dir, overdraw));
    vertices[i * 9 + 5].color = fadeOutColor;

    vertices[i * 9 + 6].pos = prevPoint;
    vertices[i * 9 + 7].pos = curPoint;
    vertices[i * 9 + 8].pos = ccpAdd(curPoint, ccpMult(dir, overdraw));
    vertices[i * 9 + 8].color = fadeOutColor;

    prevPoint = curPoint;
    prevDir = dir;
    angle += anglePerSegment;
  }

  CCRenderer *renderer = [CCRenderer currentRenderer];
  GLKMatrix4 projection;
  [renderer.globalShaderUniforms[CCShaderUniformProjection] getValue:&projection];
  CCRenderBuffer buffer = [renderer enqueueTriangles:numberOfSegments * 3 andVertexes:numberOfSegments * 9 withState:self.renderState globalSortOrder:1];

  CCVertex vertex;
  for (int i = 0; i < numberOfSegments * 9; i++) {
    vertex.position = GLKVector4Make(vertices[i].pos.x, vertices[i].pos.y, 0.0, 1.0);
    vertex.color = GLKVector4Make(vertices[i].color.r, vertices[i].color.g, vertices[i].color.b, vertices[i].color.a);
    CCRenderBufferSetVertex(buffer, i, CCVertexApplyTransform(vertex, &projection));
  }
	
  for (unsigned int i = 0; i < numberOfSegments * 3; i++) {
    CCRenderBufferSetTriangle(buffer, i, i*3, (i*3)+1, (i*3)+2);
  }

  free(vertices);
}

- (void)fillLineTriangles:(LineVertex *)vertices count:(NSUInteger)count withColor:(ccColor4F)color
{
  if (!count) {
    return;
  }

	ccColor4F fullColor = color;
	fullColor.r *= fullColor.a;
	fullColor.g *= fullColor.a;
	fullColor.b *= fullColor.a;
	ccColor4F fadeOutColor = ccc4f(0, 0, 0, 0); // Premultiplied alpha.

  for (int i = 0; i < count / 18; ++i) {
    for (int j = 0; j < 6; ++j) {
      vertices[i * 18 + j].color = fullColor;
    }

    //! FAG
    vertices[i * 18 + 6].color = fadeOutColor;
    vertices[i * 18 + 7].color = fullColor;
    vertices[i * 18 + 8].color = fadeOutColor;

    //! AGD
    vertices[i * 18 + 9].color = fullColor;
    vertices[i * 18 + 10].color = fadeOutColor;
    vertices[i * 18 + 11].color = fullColor;

    //! BHC
    vertices[i * 18 + 12].color = fullColor;
    vertices[i * 18 + 13].color = fadeOutColor;
    vertices[i * 18 + 14].color = fullColor;

    //! HCI
    vertices[i * 18 + 15].color = fadeOutColor;
    vertices[i * 18 + 16].color = fullColor;
    vertices[i * 18 + 17].color = fadeOutColor;
  }

  CCRenderer *renderer = [CCRenderer currentRenderer];
	
  GLKMatrix4 projection;
  [renderer.globalShaderUniforms[CCShaderUniformProjection] getValue:&projection];
  CCRenderBuffer buffer = [renderer enqueueTriangles:count/3 andVertexes:count withState:self.renderState globalSortOrder:1];
	
	CCVertex vertex;
	for (unsigned int i = 0; i < count; i++) {
    vertex.position = GLKVector4Make(vertices[i].pos.x, vertices[i].pos.y, 0.0, 1.0);
    vertex.color = GLKVector4Make(vertices[i].color.r, vertices[i].color.g, vertices[i].color.b, vertices[i].color.a);
    CCRenderBufferSetVertex(buffer, i, CCVertexApplyTransform(vertex, &projection));
	}
	
	for (unsigned int i = 0; i < count/3; i++) {
    CCRenderBufferSetTriangle(buffer, i, i*3, (i*3)+1, (i*3)+2);
	}
	
	for (unsigned int i = 0; i < [circlesPoints count] / 2;   ++i) {
    LinePoint *prevPoint = [circlesPoints objectAtIndex:i * 2];
    LinePoint *curPoint = [circlesPoints objectAtIndex:i * 2 + 1];
    CGPoint dirVector = ccpNormalize(ccpSub(curPoint.pos, prevPoint.pos));

    [self fillLineEndPointAt:curPoint.pos direction:dirVector radius:curPoint.width * 0.5f andColor:color];
  }
  [circlesPoints removeAllObjects];
}

- (NSMutableArray *)calculateSmoothLinePoints
{
  if ([points count] > 2) {
    NSMutableArray *smoothedPoints = [NSMutableArray array];
    for (unsigned int i = 2; i < [points count]; ++i) {
      LinePoint *prev2 = [points objectAtIndex:i - 2];
      LinePoint *prev1 = [points objectAtIndex:i - 1];
      LinePoint *cur = [points objectAtIndex:i];

      CGPoint midPoint1 = ccpMult(ccpAdd(prev1.pos, prev2.pos), 0.5f);
      CGPoint midPoint2 = ccpMult(ccpAdd(cur.pos, prev1.pos), 0.5f);

      int segmentDistance = 2;
      float distance = ccpDistance(midPoint1, midPoint2);
      int numberOfSegments = MIN(128, MAX(floorf(distance / segmentDistance), 32));

      float t = 0.0f;
      float step = 1.0f / numberOfSegments;
      for (NSUInteger j = 0; j < numberOfSegments; j++) {
        LinePoint *newPoint = [[LinePoint alloc] init];
        newPoint.pos = ccpAdd(ccpAdd(ccpMult(midPoint1, powf(1 - t, 2)), ccpMult(prev1.pos, 2.0f * (1 - t) * t)), ccpMult(midPoint2, t * t));
        newPoint.width = powf(1 - t, 2) * ((prev1.width + prev2.width) * 0.5f) + 2.0f * (1 - t) * t * prev1.width + t * t * ((cur.width + prev1.width) * 0.5f);

        [smoothedPoints addObject:newPoint];
        t += step;
      }
      LinePoint *finalPoint = [[LinePoint alloc] init];
      finalPoint.pos = midPoint2;
      finalPoint.width = (cur.width + prev1.width) * 0.5f;
      [smoothedPoints addObject:finalPoint];
    }
    //! we need to leave last 2 points for next draw
    [points removeObjectsInRange:NSMakeRange(0, [points count] - 2)];
    return smoothedPoints;
  } else {
    return nil;
  }
}

- (void)draw:(CCRenderer *)renderer transform:(const GLKMatrix4 *)transform
{
  //TODO figure out why the color is this way
   // ccColor4F color = {0, 0.5, 0, 1};
    //ccColor4F color = {0.7, 0.3, 0.7, 0.2};// -- highlighter marker
    //ccColor4F color = {0.7, 0.0, 0.7, 0.5};// -- glow marker
   // ccColor4F color = {1, 0, 0, 1}; //red color solid
  [renderTexture begin];

  NSMutableArray *smoothedPoints = [self calculateSmoothLinePoints];
  if (smoothedPoints) {
    [self drawLines:smoothedPoints withColor:penColor];
  }
  [renderTexture end];
}

#pragma mark - Math

#pragma mark - GestureRecognizers

- (float)extractSize:(UIPanGestureRecognizer *)panGestureRecognizer
{
  //! result of trial & error
  float vel = ccpLength([panGestureRecognizer velocityInView:panGestureRecognizer.view]);
  float size = vel / 166.0f;
  size = clampf(size, 1, 40);

  if ([velocities count] > 1) {
    size = size * 0.2f + [[velocities objectAtIndex:[velocities count] - 1] floatValue] * 0.8f;
  }
  [velocities addObject:[NSNumber numberWithFloat:size]];
  return size;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
  const CGPoint point = [[CCDirector sharedDirector] convertToGL:[panGestureRecognizer locationInView:panGestureRecognizer.view]];

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    [points removeAllObjects];
    [velocities removeAllObjects];

    float size = [self extractSize:panGestureRecognizer];

    [self startNewLineFrom:point withSize:size];
    [self addPoint:point withSize:size];
    [self addPoint:point withSize:size];
  }

  if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    //! skip points that are too close
    float eps = 1.5f;
    if ([points count] > 0) {
      float length = ccpLength(ccpSub([(LinePoint *)[points lastObject] pos], point));

      if (length < eps) {
        return;
      } else {
      }
    }
    float size = [self extractSize:panGestureRecognizer];
    [self addPoint:point withSize:size];
  }

  if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
    float size = [self extractSize:panGestureRecognizer];
    [self endLineAt:point withSize:size];
  }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
  ////[renderTexture beginWithClear:1.0 g:1.0 b:1.0 a:0];
  //[renderTexture end];
}
@end