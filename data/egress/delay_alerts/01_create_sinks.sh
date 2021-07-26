#!/usr/bin/env bash


curl -X PUT -H "Content-Type: application/json" http://localhost:38083/connectors/sink-http-telegram-delay-alerts-07/config \
      -d '{
              "connector.class": "io.confluent.connect.http.HttpSinkConnector",
              "request.method": "post",
              "http.api.url": "https://api.telegram.org/bot${file:/data/credentials.properties:TELEGRAM_BOT_API_KEY}/sendMessage",
              "headers": "Content-Type: application/json",
              "topics": "TRAINS_DELAYED_ALERT_TG",
              "tasks.max": "1",
              "batch.prefix": "{\"chat_id\":\"-364377679\",\"parse_mode\": \"markdown\",",
              "batch.suffix": "}",
              "batch.max.size": "10",
              "regex.patterns":".*\\\{MESSAGE=(.*)\\\}.*",
              "regex.replacements": "\"text\":\"$1\"",
              "regex.separator": "~",
              "confluent.license": "",
              "confluent.topic.bootstrap.servers": "broker:29092",
              "confluent.topic.replication.factor": 1,
              "key.converter": "org.apache.kafka.connect.storage.StringConverter"
          }' 
