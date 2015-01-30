//
//  SceneViewController.h
//  CCStoryboard
//
//  Created by Dimitri Giani on 29/07/14.
//  Copyright (c) 2014 Dimitri Giani. All rights reserved.
//

#import "CocosViewController.h"
#import "IntroScene.h"

enum SceneType
{
	kSceneType_Demo,
	kSceneType_SpriteBuilder
};

@interface SceneViewController : CocosViewController

@property (nonatomic, readwrite) enum SceneType	sceneType;
@property (nonatomic, strong) IntroScene *introScene;

@end
