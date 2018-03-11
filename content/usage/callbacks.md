+++
title = "Register Callbacks"
chapter = false
weight = 6
pre = ""
+++


A Wire bot is basically a listener that processes updates from Telegram by executing user-defined functions. Those functions must be registered before starting the bot.

In this example we register a callback that will resend the text content of every message it receives (see [Echo Bot](http://localhost:1313/examples/echo/)).
```java
 bot.on(UpdateType.MESSAGE, ctx -> {

    ctx.reply(ctx.getMessage().getText());

    return null;
});
```

**CAVEAT:** Wire is written in [Kotlin](https://kotlinlang.org), and callbacks are implemented as functions of type `(ctx: Context) -> Unit`. This means that while in Kotlin we can write our lambda as:  
```java
 bot.on(UpdateType.MESSAGE) { ctx ->
    ctx.reply(ctx.getMessage().getText());
}
```

in Java we need to add `return null;` at the end to compensate for the `Unit` return type. This is unfortunate but necessary.

Note that callbacks are chainable, as every hook method returns the instance of `Wire` 
```java
bot.onCommand("start", ctx -> {})
    .onCommand("stop", ctx -> {})
    .onText("Hello", ctx -> {});
```

## Available callbacks
---
### Update Type
```java
public Wire on(UpdateType updateType, Function<Context, Unit> callback)
```
Example
```java
bot.on(UpdateType.MESSAGE, ctx -> {
    //stuff
    return null;
});
```
---
### Callback Query
```java
bot.onCallbackQuery(Function<Context, Unit> callback)
```
Shortcut for 
```java
bot.on(UpdateType.CALLBACK_QUERY, ctx -> {
    //stuff
    return null;
});
```
---

### Command
```java
public Wire onCommand(String command, Function<Context, Unit> callback)
```
Example
```java
bot.onCommand("help", ctx -> {
    //do stuff on '/heòp' command
    return null;
});
```
---

### Start command
```java
bot.onStartCommand(Function<Context, Unit> callback)
```
Shortcut for 
```java
bot.onCommand("start", ctx -> {
    //stuff
    return null;
});
```
---

### Text
```java
bot.onText(kotlin.text.Regex regex, Function<Context, Unit> callback)
```
Example
```java
bot.onText("\\w* Hello", ctx -> {
    //do stuff when message text matches the regex
    return null;
});
```
---

### Message Entity Type
```java
bot.onMessageEntity(MessageEntityType messageEntityType, Function<Context, Unit> callback)
```
Example
```java
bot.onMessageEntity(MessageEntityType.MENTION, ctx -> {
    //do stuff if the message has at least a mention entity
    return null;
});
```
---
### Action (callback query data)
Run when a callback query with the provided data is processed
```java
bot.onAction(String data, Function<Context, Unit> callback)
```
Example
```java
bot.onAction("login", ctx -> {
    //stuff
    return null;
});
```
---

## Special Hooks

Wire has two types of special callbacks that can be registered and executed on specific conditions.

### Catch
```java
public Wire catch(Function<? extends Throwable, Unit> handler)
```

Catch is executed when an error occurs. The default implementation logs to an [SLF4J](https://www.slf4j.org/) logger with ERROR level.
`logger.error(t, t.getMessage();`

You can specify your own by calling:  
```java
bot.catch(t -> {
    // do something with this Throwable
    return null;
});
```

### Use

Use is a bit special. It allows to register functions that are run in stack-like, sequential manner on every update, before processing the callbacks.
See [Middlewares](http://localhost:1313/usage/middlewares/) for more details.  

Example: 

```java

bot.use((ctx, next) -> {
    ctx.reply("I'm First");
    next.invoke(ctx);
    return null;
});
    
bot.use((ctx, next) -> {
    ctx.reply("I'm Second");
    next.invoke(ctx);
    return null;
});
```

We all agree that the syntax is a bit clunky in Java. As you can see it's much better in Kotlin:  
```java
bot.use {ctx, next -> 
    ctx.reply("I'm First");
    next(ctx);
}
    
bot.use {ctx, next -> 
    ctx.reply("I'm Second");
    next(ctx);
}
```