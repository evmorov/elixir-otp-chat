Locally:

```
iex --sname client1 -S mix
```

Remote server:

```
iex --name client1@$your_ip --cookie iamafriend -S mix
```

Then:

```
ChatClient.start(chat_server: :"$server_node")
```
