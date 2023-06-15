# cloud-bot-deploy-template

Docker Compose サンプル bot 。

## function_bot

bitFlyer の REST API から 1 度のみ Ticker を取得して print する bot。 クラウド関数 / バッチJob サービス向け。

```bash
docker compose up --build function_bot
```

## monolithic_bot

bitFlyer の REST API から毎秒 Ticker を取得して print する常駐型 bot 。 長時間のワークロードを実行できるサービス向け。

```bash
docker compose up --build monolithic_bot
```

-> Ctrl+C で抜ける。
