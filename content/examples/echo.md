+++
title = "Echo Bot"
chapter = false
weight = 4
pre = ""
+++

Let's write a simple echo bot that replies with the same message

```java 
public class EchoBot {

    public static void main(String[] args) {

        // Create our bot instance
        final Wire bot = new Wire("token");

        // Configure behavior
        bot.on(UpdateType.MESSAGE, ctx -> {

            ctx.reply(ctx.getMessage().getText());

            return null; // Mandatory!
        });

        // Start polling
        bot.start();
    }
}
```

As you can see the bot configuration is pretty straight forward, and if you have already used [TelegrafJS]() you'll recognize most of the syntax.  

Let's break it down a bit.  
First we create our bot instance by passing our Telegram token:  
`final Wire bot = new Wire("token");`

Then we register a callback for incoming message updates. This is basically everything that is not a callback query:  
```java
 bot.on(UpdateType.MESSAGE, ctx -> {

    ctx.reply(ctx.getMessage().getText());

    return null;
});
```

**CAVEAT:** Wire is written in [Kotlin](), and callbacks are implemented as functions of type `(ctx: Context) -> Unit`. This means that while in Kotlin we can write our lambda as:  
```java
 bot.on(UpdateType.MESSAGE) { ctx ->
    ctx.reply(ctx.getMessage().getText());
}
```

in Java we need to add `return null;` at the end to compensate for the `Unit` return type. This is unfortunate but necessary.