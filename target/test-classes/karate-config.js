function fn() {
  var env = karate.env; // get system property 'karate.env'
//  var env = 'test-fidoV2';
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'test-fidoV2';
  }
  var uuid = function(){ return java.util.UUID.randomUUID() + '' }
   var source = 'source'
  var config = {
    env: env,
    source : source,
     headers: {
                "x-reference-id": uuid(),
                "x-request-id": "Via_Automation_request_id" + uuid(),
                "Content-Type": "application/vnd.monnai.v1.2+json",
                "x-timeout":60000,
                "Accept": "application/json"
            }
  }
   switch (env) {

              case "dev-m":
                  config.requestUrl = "https://dev.monnai.com";
                  config.authUrl = "https://auth-dev.monnai.com";
  //                config.headers.Authorization = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiN2ZlODY0YTEtODcxOS00NGY0LTkyMjAtMDgzODQ3Mzc4MGE5IiwiZXZlbnRfaWQiOiI3MWM2YzU4OC04YzRhLTRiNzUtYTNiZS1hYzgyN2ZmYTk1NmYiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzMyNTExODg4LCJleHAiOjE3MzI1OTgyODgsImlhdCI6MTczMjUxMTg4OSwianRpIjoiZmFkNTBmMmItZDMzMi00MWE4LWI5YzItNDlkYmVjZTBhYzBkIiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.cHjyIQkGkLD38xTl1mKCle1SGk5ptYa3STQkSWY8Hgc40E4ztSD0mejJbdAo0P1_QZoXQ-WsxjqINZjOr2kUQ4tspNlI3rYnXGL3tafNAiTCvcJFfaFHJF-aO_IYQeAkqft6Hf0M0uA0ImEaNLAadUJFmt2-loEzmj0k4pFrvCgSV0hWHZOvWm_GFGFNcfafAGJc-Y1hSMxudr4nVVOo0Ep6Gll89THx3776gvNLpBAQHNGNJ3i4Ntk8bcGVIfh7U6IyMLeHVvT-q9KH3qdlRx_-U1iSZ3mNb9oAkdCrFbmJ3psyG59h5-ZxhLM2jfmw7lgxsxWHn8_8gCNESFeSAw";
  //                config.headers.id_token = "eyJraWQiOiJlbGNJVGl4ZStUbmU0cUZGenU0ZlFvZmlsekl2MFdLaUU3anR4OHRsZ2ZNPSIsImFsZyI6IlJTMjU2In0.eyJhdF9oYXNoIjoiTjB1NnlaUm9NRFlwWXBmbWlaTk1sZyIsInN1YiI6ImY0OWI5YzVlLTljNDUtNDg2MC1hN2UyLTA3MGYyZWI3YTRmOSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJyb2xlcyI6Ik1PTk5BSV9BRE1JTiIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5hcC1zb3V0aGVhc3QtMS5hbWF6b25hd3MuY29tXC9hcC1zb3V0aGVhc3QtMV8xV2JmQk83eUYiLCJjb2duaXRvOnVzZXJuYW1lIjoiZjQ5YjljNWUtOWM0NS00ODYwLWE3ZTItMDcwZjJlYjdhNGY5IiwiZ2l2ZW5fbmFtZSI6IlNhbmpheWEiLCJvcmlnaW5fanRpIjoiN2ZlODY0YTEtODcxOS00NGY0LTkyMjAtMDgzODQ3Mzc4MGE5IiwiYXVkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJldmVudF9pZCI6IjcxYzZjNTg4LThjNGEtNGI3NS1hM2JlLWFjODI3ZmZhOTU2ZiIsInRlbmFudE5hbWUiOiJNb25uYWkiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTczMjUxMTg4OCwidGVuYW50SWQiOiIwMUZaRDJWMURGTjAxSzM5UThDQllLVFhHViIsImV4cCI6MTczMjU5ODI4OCwiaWF0IjoxNzMyNTExODg5LCJmYW1pbHlfbmFtZSI6Ikdvd2RhciIsImp0aSI6IjNiNGY2ZjA3LTcxYjctNDc4ZC1hZmU2LWFmOGFmYzQyMmNkYyIsImVtYWlsIjoic2FuamF5YUBtb25uYWkuY29tIn0.nMoTwN5cX0Oz7PAjEZHgvCVmREsZGb6Hyg3W-61YO8QuHMYPa1sDCTmxDMZugsk7VWt5EYIgc_1p-F47vofJP8iy8_lo5jODia00llXWiRO7S0itkQCq7ZQrV7bQdlMFs6FF9I0S3PFzh4b7fP63vpWabejmv3-5NDIY1zV8JpT_tVB7jU5XLpG60EM3TSerTr9BVJzz8WnYegGDXa6wjYBQEV703wg92u4czNq3kugz0IAXP4MrRjjSyVToUYWelIvlmvnAgef4ICTHlBe_qd0nLWJudfnT6iySiSfoTLwm_xhi1cDfqzJJVYgfH3718YXmt1ccwH4MHuo7FsmtuQ";
                  break;

             case "release-m":
                    config.requestUrl = "https://release.monnai.com";
                    config.authUrl = "https://release-auth.monnai.com";
                    break;
             case "release-y":
                    config.requestUrl = "https://release.monnai.com";
                    config.authUrl = "https://release-auth.monnai.com";
                    break;
             case "release-fido":
                    config.requestUrl = "https://release.monnai.com";
                    config.authUrl = "https://release-auth.monnai.com";
                    break;
             case "release-fidoV2":
                    config.requestUrl = "https://release.monnai.com";
                    config.authUrl = "https://release-auth.monnai.com";
                    config.email_custom_tenant = 'release-custom_email_basic';
                    config.fidoV1_social = 'release-fido';
                    break;
             case "release-seon":
                    config.requestUrl = "https://release.monnai.com";
                    config.authUrl = "https://release-auth.monnai.com";
                    break;
             case "release-custom_email_basic":
                   config.requestUrl = "https://release.monnai.com";
                   config.authUrl = "https://release-auth.monnai.com";
                   break;


             case "test-m":
                   config.requestUrl = "https://test.monnai.com";
                   config.authUrl = "https://test-auth.monnai.com";
                   break;
             case "test-fido":
                   config.requestUrl = "https://test.monnai.com";
                   config.authUrl = "https://test-auth.monnai.com";
                   break;
             case "test-fidoV2":
                   config.requestUrl = "https://test.monnai.com";
                   config.authUrl = "https://test-auth.monnai.com";
                   config.email_custom_tenant = 'test-custom_email_basic';
                   config.fidoV1_social = 'test-fido';
                   break;
             case "test-seon":
                  config.requestUrl = "https://test.monnai.com";
                  config.authUrl = "https://test-auth.monnai.com";
                  break;

  //  General auth gen curl for any env with general credentials
              case "env-release-gen":
                   config.requestUrl = "https://release.monnai.com";
                   config.authUrl = "https://release-auth.monnai.com";
                   break;
              case "env-test-gen":
                   config.requestUrl = "https://test.monnai.com";
                   config.authUrl = "https://test-auth.monnai.com";
                   break;
              case "env-app-gen":
                    config.requestUrl = "https://app.monnai.com";
                    config.authUrl ="https://auth.monnai.com";
                    break;
               case "env-app-sg-gen":
                    config.requestUrl = "https://app-sg.monnai.com";
                    config.authUrl ="https://auth-sg.monnai.com";
                    break;
               case "env-app-id-gen":
                    config.requestUrl = "https://app-id.monnai.com";
                    config.authUrl ="https://auth-sg.monnai.com";
                    break;
               case "env-app-us-gen":
                    config.requestUrl = "https://app-us.monnai.com";
                    config.authUrl ="https://auth-us.monnai.com";
                    break;
  //  Yashas manual testing tenant auth gen curl for any env with general credentials

              case "app-us-y":
                    config.requestUrl = "https://app-us.monnai.com";
                    config.authUrl ="https://auth-us.monnai.com";
                    break;
              case "app-y":
                    config.requestUrl = "https://app.monnai.com";
                    config.authUrl ="https://auth.monnai.com";
                    break;
              case "app-sg-y":
                  config.requestUrl = "https://app-sg.monnai.com";
                  config.authUrl ="https://auth-sg.monnai.com";
                  break;
              case "app-id-y":
                  config.requestUrl = "https://app-sg.monnai.com";
                  config.authUrl ="https://auth-sg.monnai.com";
                  break;


  // 14-dec-2023 -> Disabled Production regression.
//              case "app":
//                  config.requestUrl = "https://app.monnai.com";
//                  config.authUrl ="https://auth.monnai.com";
//                  break;
//              case "app-sg":
//                  config.requestUrl = "https://app-sg.monnai.com";
//                  config.authUrl ="https://auth-sg.monnai.com";
//                  break;
//              case "app-id":
//                  config.requestUrl = "https://app-id.monnai.com";
//                  config.authUrl ="https://auth-sg.monnai.com";
//                  break;
//              case "app-us":
//                  config.requestUrl = "https://app-us.monnai.com";
//                  config.authUrl ="https://auth-us.monnai.com";
//                  break;

              default:
                    config.requestUrl = "https://test.monnai.com";
                    config.authUrl = "https://test-auth.monnai.com";
                    config.email_custom_tenant = 'test-custom_email_basic';
                    config.fidoV1_social = 'test-fido';
                    break;
          }
  //      karate.configure('connectTimeout', 5000);
  //      karate.configure('readTimeout', 5000);
      return config;
  }