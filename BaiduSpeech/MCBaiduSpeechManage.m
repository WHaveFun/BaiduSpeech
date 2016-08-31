//
//  MCBaiduSpeechManage.m
//  BaiduVoice
//
//  Created by Marcus on 16/8/26.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import "MCBaiduSpeechManage.h"
#import "BDSSpeechSynthesizer.h"
@interface MCBaiduSpeechManage ()<BDSSpeechSynthesizerDelegate>

@end

@implementation MCBaiduSpeechManage
+ (id) sharedBaiduVoiceManage
{
    static id manage;
    if (manage == nil)
    {
        manage = [[MCBaiduSpeechManage alloc] init];
        
    }
    return manage;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //显示语音日志
        [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];

        [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate: self];
        
         /// 设置线程,默认使用主线程
        [[BDSSpeechSynthesizer sharedInstance] setSDKCallbackQueue:dispatch_queue_create("baiduVoiceQueue", DISPATCH_QUEUE_SERIAL)];
        /// 在线相关设置
        [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"S9qVzcBQkKaeFzt9zxDSKkZM" withSecretKey:@"2015ebaf787140cd475855146025e6aa"];
       
        // 合成参数设置
        ///女声
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:
         [NSNumber numberWithInt:BDS_SYNTHESIZER_SPEAKER_FEMALE]
                                                      forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
        ///音量 0 ~9
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:9] forKey:BDS_SYNTHESIZER_PARAM_VOLUME];
        
        ///语速 0 ~9
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:6] forKey:BDS_SYNTHESIZER_PARAM_SPEED];
        
        ///语调 0 ~9
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam: [NSNumber numberWithInt:5] forKey:BDS_SYNTHESIZER_PARAM_PITCH];
        ///mp3音质  压缩的16K
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:
         [NSNumber numberWithInt: BDS_SYNTHESIZER_AUDIO_ENCODE_MP3_16K]
                                                      forKey:BDS_SYNTHESIZER_PARAM_AUDIO_ENCODING ];
       
        
        
        
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithFloat:10.0] forKey:BDS_SYNTHESIZER_PARAM_ONLINE_REQUEST_TIMEOUT];
        
        /// 离线相关设置
        
        NSString* offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female" ofType:@"dat"];
        NSString* offlineEngineTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_Text" ofType:@"dat"];
        NSString* offlineEngineEnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
        NSString* offlineEngineEnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_Text" ofType:@"dat"];
        ///无法实现离线语音请检查以下部分
        NSError* err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineEngineTextData speechDataPath:offlineEngineSpeechData licenseFilePath:nil withAppCode:@"8553284"];
        
        if(err)
        {
            /// Get offline TTS license from server failed with error -101  请检查包名设置
            NSLog(@"_________________%@",[err localizedDescription]);
        }
        err = [[BDSSpeechSynthesizer sharedInstance] loadEnglishDataForOfflineEngine:offlineEngineEnglishTextData speechData:offlineEngineEnglishSpeechData];
        if(err)
        {
            NSLog(@"_________________%@",err);
        }
        

    }
    return self;
}
+ (void)initBaiduVoice
{
    [[MCBaiduSpeechManage sharedBaiduVoiceManage]initBaiduVoice];
}
- (void)SpakeString:(NSString *)string
{
    dispatch_sync([[BDSSpeechSynthesizer sharedInstance] getCurrentCallbackQueue], ^ {
    
        [[BDSSpeechSynthesizer sharedInstance] speakSentence:string withError:nil];
    });
}

+ (void)SpakeString:(NSString *)string
{
    [[MCBaiduSpeechManage sharedBaiduVoiceManage] SpakeString:string];
}


- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence
{
    
}
- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence
{
    
}
- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence;
{
    NSLog(@"kaishishuohua ");
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence
{
    
}


- (void)synthesizerNewDataArrived:(NSData *)newData
                       DataFormat:(BDSAudioFormat)fmt
                   characterCount:(int)newLength
                   sentenceNumber:(NSInteger)SynthesizeSentence
{
    
}



- (void)synthesizerTextSpeakLengthChanged:(int)newLength
                           sentenceNumber:(NSInteger)SpeakSentence
{
    
}


- (void)synthesizerdidPause
{
    
}

- (void)synthesizerPaused:(BDSAudioPlayerPauseSources)src __attribute__((deprecated("src parameter will be removed from paused callback. Current implementation of synthesizerPaused is kept in for backward compatibility for now, but will always pass BDS_AUDIO_PLAYER_PAUSE_SOURCE_USER as pause source. Start using - (void)synthesizerdidPause; instead.")))
{
    
}

- (void)synthesizerResumed
{
    
}



@end
