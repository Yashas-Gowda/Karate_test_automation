function(){

    var env = karate.env; // get java system property 'karate.envData' from TestRunner.java
    karate.log('karate.envData system property was:', env);

    if (!env) {
        env = 'dev'; // a custom 'intelligent' default
      }

    var config = { // base config JSON
        env,
        headers: {
            "x-reference-id": "AMS-test-1",
            "x-request-id": "AMS-req-id-1",
            "Content-Type": "application/vnd.monnai.v1.2+json",
            "Accept": "application/json"
        }
      };
    switch(env) {
        case "dev":
            config.requestUrl = "https://release.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiMjZkMjc3YjUtYjc3OC00MmUyLTlmNjQtZTk4YmI5MWY5ODVlIiwiZXZlbnRfaWQiOiI5MmYzODEwZi0zZDViLTQ0Y2EtYWEwNi1kNzhlMzU0Zjc3OWEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjg3OTM2NDQ1LCJleHAiOjE2ODgwMjI4NDUsImlhdCI6MTY4NzkzNjQ0NiwianRpIjoiMzNkZjkwMWQtNmI3MS00MzRhLTg3ZmUtNDczYmUwOWNiYWY0IiwidXNlcm5hbWUiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIifQ.NOOpTjNWHIRIjirlCJ8q4ZKsEHeccJ5Nz81oYKgm8jrjCsfcnmS8zTgqLO3Ear_UCC10nQdzXVPIp0O5eYmOJUAWjrFCTSnODfBAKcVfTt5Ql31Km7QGfHBnl96U5nOTv7728jDU46HnUrNlU790N3ZKy6AVn2CJoZOIY3Q3M_vLJr0CnZU3Bw9J9EAydUfpOXsSPSd_sbieDcMAdEQvygXwR9aGwzCkCCvAi3_kVLbONb9LCowqpucB_rAAMvsrudEGk0Uz5xqIa9FfK6jaP5Jff2QCKQ8VNnscuhRsQes2zN-fHobkZfGQYpcTKB0oaxiRqmZy-A9DNDChyJ3kMg";
            break;
        case "release":
            config.requestUrl = "https://release.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiNjg5ZjRjZTktNWJhOC00YmJhLTk0ZDctOWZlYTM1OTZhMzVlIiwiZXZlbnRfaWQiOiJlMmQ3N2Y3MS02YjhkLTQ3MmItOTA3Ny0xOWZkYjFlZjU0ODciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjg3NzU0ODEyLCJleHAiOjE2ODc4NDEyMTIsImlhdCI6MTY4Nzc1NDgxMywianRpIjoiZjRiZDhiODUtOGRmZi00ZDJmLWJjZGEtM2E4YTFhZjg0MDEyIiwidXNlcm5hbWUiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIifQ.H5_-_X4xd-Qyg1cN6QJT9J_ZjkTpsdORB08GO6zjse5npjEfDx-c0yzoKudInjHTlna2zw99GWcElCjU03XKr-ebSUQPGrYTvLpOBgvEgvTIhkYTrgWBrpd9SivY-FxL9Ivw3uFGwtRaRdt4GyAJelu7TMJLodD_d0x2QVRT_IGDeOc1XtWcOgMnGIWkXLGKZb6Yg7sRfY2Nl2FvqXwZPM6UpX4sxk9Tx2TaZoThAtgPyCLHohqd5jPhm8qbT_Qnz3kEIRlM5ybWEO7A1bYxDe1HkE9JavRVbQTOHFgZRUhhh6uEIT5_2Mze9FRZnabIZzrSQR_8Py1jBoHhHl99TA";
            break;
        case "test":
            config.requestUrl = "https://test.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiNmU1YmRjYzctYmVkYy00NjFhLWIzZGEtZGU0ZjFjYzA4MGE2IiwiZXZlbnRfaWQiOiJjNmJhMjIyNC1jZjg5LTQ3MGUtYTM3Ni1iMTJkNzBhYTVkNzQiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjc4MTg2NzY4LCJleHAiOjE2NzgyNzMxNjgsImlhdCI6MTY3ODE4Njc2OSwianRpIjoiNDc5YjlhMzItZmY0Ny00YTdmLTkwZTMtYzhkN2VmOTBlNjM4IiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.NG2tCgokzdvYxq7NZcJDquwK9IsX33trvaD62HYUKjOvLY8ss0k0pkFvP-tXZs2_S6PVKtC8FGsUzwEKB-iT7Owu-esWA6vEy1itzjTIpP-J_slCkhuXqkHL1KyJIoW-Ygi9mNSkc5H1WkA9fbdIeuZgKymiEI5JtmHgPJHHI9u_CtRYY-Gv-uMWeau5Eqpdy6YwbgeNpjMrHugRODCsLPgkHf9merGj0-FV6QeTnZjjbVQAdDTlb9w6rBjU8dHqbnwrxRll7lc8lVTv8s9A0Ini6IZUGoMahVsNloFyMQMuya3RQP9zWzaWyROjdYC0eOc8uPcpt3fhZvvwtds8Bw";
            break;
        default:
            config.requestUrl = "https://dev.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiNzgxMDA5ZWYtMmIzOS00NjJhLWE0ZDctZWQ0ODkzNTI1Zjk0IiwiZXZlbnRfaWQiOiI1MTM0YzlhNy02ZTU5LTQzNjctYWNjYS1jZDdmZDNkZjY1ODciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjgwNTEzODU5LCJleHAiOjE2ODA2MDAyNTksImlhdCI6MTY4MDUxMzg2MCwianRpIjoiMWFhODQxYWItNGEzMC00YzA3LWE0MjItNzIxM2MyYzI2ZjVkIiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.fHXQHdUh8wwHcG2fAuUhFGUdX86DNsTjifU05G6FLdnmURzgxGcLEqCIklhWcnBM78QSYErJLTk08cTDowFKASvd42RmQgocVGodSuu43-x952babebBzRI0qQs6QTVSvJw1uCKN7gFzQY2zDy4nM2oxuVeRHDY6D5t-ukWwzcymQNmY7Df-eHELz5j9KqF1yW8J9F2cbUwvATx_dUxNrrw-ZBhYzbReYf-aLc7wCVV2256vP6kvMdSGxnnYbWs78OUQ6IrhAlsOVItkyoT9I4oP6fxMnQt-NbBSezUUGzz7tHmp8rX3BgtkFHqyCX1GBde3dqzSoxgjaiv0JqDCpA";
            break;
    }

    return config;
}