# BaiduSpeech
一行代码简单调用百度语音合成
## 实现效果

```
[MCBaiduSpeechManage SpakeString:@"你好"];
```

## **配置注意事项 主要针对离线语音合成**
1.   在百度语音开发者平台 如果你不是通过直接创建应用,而是通过应用管理开通语音合成功能,拿到的App ID/API Key/Secret Key name  那么你需要在 应用管理>>>管理包名 重新设置包名,否则这将影响 离线语音的使用.
2.   导入datfile时不要导入 offline_engine_tmp_license.dat  这个是百度demo的离线语音证书,配置完成后会自动下载所需要的离线证书.
3.   在使用离线语音功能的时候,要确保离线语音证书已下载成功.换句话说第一次要联网,之后才可使用离线语音功能.
4. iOS9及后 在plist文件中配置http支持.
  
## 代码说明
按官方说明配置导入SDK,请看上述的注意事项
导入头文件

```
#import "BDSSpeechSynthesizer.h"
``` 
### 配置云在线语音合成
  
```
//显示语音日志
        [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];

        [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate: self];
        
         /// 设置线程,默认使用主线程
        [[BDSSpeechSynthesizer sharedInstance] setSDKCallbackQueue:dispatch_queue_create("baiduVoiceQueue", DISPATCH_QUEUE_SERIAL)];
        /// 在线相关设置
        [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"yourAK" withSecretKey:@"yourSK"];
        //在线语音请求超时时间
        [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithFloat:10.0] forKey:BDS_SYNTHESIZER_PARAM_ONLINE_REQUEST_TIMEOUT];
        
```

### 语音合成参数设置


```
// 合成参数设置 可根据需求自行修改
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


```
### 配置离线语音合成


```

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
        
```
