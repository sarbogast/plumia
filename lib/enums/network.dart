enum Network {
  mainnet,
  morden,
  ropsten,
  rinkeby,
  goerli,
  kovan,
  private;

  int get chainId {
    switch (this) {
      case Network.mainnet:
        return 1;
      case Network.morden:
        return 2;
      case Network.ropsten:
        return 3;
      case Network.rinkeby:
        return 4;
      case Network.goerli:
        return 5;
      case Network.kovan:
        return 42;
      case Network.private:
        return 1337;
    }
  }

  static Network? fromChainId(int chainId) {
    switch (chainId) {
      case 1:
        return Network.mainnet;
      case 2:
        return Network.morden;
      case 3:
        return Network.ropsten;
      case 4:
        return Network.rinkeby;
      case 5:
        return Network.goerli;
      case 42:
        return Network.kovan;
      case 1337:
        return Network.private;
      default:
        return null;
    }
  }
}
