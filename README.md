```shell
curl -i \
    -X POST \
    ${MCP_SERVER} \
    -H "Authorization: Bearer ${AUTH_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{
      "jsonrpc":"2.0",
      "id":1,
      "method":"initialize",
      "params":{
        "protocolVersion":"2025-03-26",
        "capabilities":{},
        "clientInfo":{
          "name":"curl",
          "version":"1.0"
        }
      }
    }' -w '\n'
```

```shell
export SESSION_ID='bc766f57-7757-42c9-8f03-7e44747f75b4'
```

export REQUEST_ID=2

```shell
curl \
    -X POST \
    ${MCP_SERVER} \
    -H "Authorization: Bearer ${AUTH_TOKEN}" \
    -H "Mcp-Session-Id: ${SESSION_ID}" \
    -H "Content-Type: application/json" \
    -d '{
      "jsonrpc":"2.0",
      "id":${REQUEST_ID},
      "method":"tools/list",
      "params":{}
    }' -w '\n'
```