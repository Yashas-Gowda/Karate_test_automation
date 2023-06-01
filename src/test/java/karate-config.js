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
            config.requestUrl = "https://dev.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiYzExN2IzNTYtMDA4Zi00MDA4LWJlYTYtNzNhNDBkZjE0ZGFlIiwiZXZlbnRfaWQiOiI0ZjZhMjliOC1kYWQ2LTRmMzktODQxZC0xYzFmM2JlNjlkNGUiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjg1NTE0ODM3LCJleHAiOjE2ODU2MDEyMzcsImlhdCI6MTY4NTUxNDgzOCwianRpIjoiMmRhZDZmNjctY2VjYy00YWJkLTkyYjktNDljYzBjOWYzN2YwIiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.M_RZ4IjJa7cA_l2D7_jvuz2vtFNKQEE7x2-cijt2Sk2u4QQI28UYq-ITOw1WFF0fD1n4KhaYbTfScLcgq8EZORZMzDPHNg6KxRs5-_-Zy4BvP8rxi7vpHRY31NIKjGLE7R4hOHc5bcgdiPdgH3cNtusVxsyoNKUAI0J4_vazur8kjL7UmxJP9rOHQ-0Mn5IHqiJdNyXL0JMCdpW0TbT7NrL52TtQynKU-DzLOePh4Z0v4AINaQnZCbyBVwQt3PzoHFHM_76iVc_azsXhQnB5cCcmr_kxNjeP-zsXBIs_M9gMWwwenOBgPcxMIL3m62x454IYV6b-Cki0XJ8pjQySGw";
            break;
        case "release":
            config.requestUrl = "https://release.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiNjk3ODRhMTQtMmRlOS00N2MxLWI2NzktMjBmMzZmZDE0YzY4IiwiZXZlbnRfaWQiOiI2MWI2NzlhMC1iNmE3LTQ2ZTgtODA0Ny0xZTU5NDk0Zjk1MTYiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjc4MTc2MzA4LCJleHAiOjE2NzgyNjI3MDgsImlhdCI6MTY3ODE3NjMwOSwianRpIjoiZGQwNmI3NjEtM2JmZC00M2U3LThhODItMzc4MTlhNmZmNTUyIiwidXNlcm5hbWUiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIifQ.QRhnTi6eqm1NVwyLZHs68OLE8ddfcm3d1gCkZH2D-OSTyvB9ccGYUmu5fGkzjnxl4aVCbXGGEb2fuVGSZN2GoJsIddUZtxhwCBJFpwV3LMcHQ8xvP1QsV52s2wcwd2H4h4ZvufzuGQqL2EQNgSnOI5BkW-YxX7EHKAddhreXtdgAggGYGlDGqCqkrJUFOclelp1YYOIiuC2YDIob6ND5rKfuT-GdXAFUjBBODI_7NZXxp_6Z7CBF1_nzmvsWPaZPkcMh3usjMkZZSutug6nEjJ65vmUV4zdKKkXm0XpgCa5xTILxEFnuAf_S33KP-533e1mHnlBNK8yih9ynxgmbRA";
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