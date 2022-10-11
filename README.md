![tests bage](https://github.com/kayumarie/ens_lookup/actions/workflows/test.yaml/badge.svg)


### Simple package to lookup ENS names
EnsLookup allows you to resolve ENS domains and receive Ethereum Addresses with a simple call `ensService.resolveName('my.eth')`

Inspired by ethers.js [resolveName implementation](https://github.com/ethers-io/ethers.js/blob/b0bd9ee162f27fb2bc51ab6a0c0694c3b48dc95f/src.ts/providers/base-provider.ts#L1165).
To learn more about ens domains refer to [official documentation](https://docs.ens.domains/)
This is early stage development so please feel free to reach out or contribute.



## Usage

```dart
void resolveEnsDomain() async {
  final client = HttpClientWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final ensService = Ens.create(Web3Client(
        'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
        client,
      ));

      final address = await ensService.resolveName('ricmoo.firefly.eth');
}
```

