Locally:

```
iex --sname client1 -S mix
```

Remote server:

```
iex --name client1@91.227.46.73 --cookie iamafriend -S mix
```

Then:

```
ChatClient.send_message("Hello!")
```
