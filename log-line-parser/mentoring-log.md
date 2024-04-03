# Mentoring conversation

## Iteration 1 was submitted (1 Mar 2024)

### owenblacker (1 Mar 2024)

Is the way I've handled string manipulation and splitting The Right Way™ to do this in Ruby?

### kotp (4 Mar 2024)

Sure, it is, but that does not mean that we can do better.

We should use attributes as opposed to instance variables directly, for the benefit it provides us when we make a mistake.

----

We do not have to use `String.new` to create a string, and we can use concatenation or a template string to make the string as well.

----

We can set our internal state in `initialize` instead of having a the line as our internal state. It pulls focus from what we are really concerned with.

----

When using `split` we are focused on something that we really do not want, in order to get to what we want. If we can find a regular expression to focus on what we want, it changes that focus.

I am looking forward to the next iteration!

## Iteration 2 was submitted (4 Mar 2024)

### owenblacker (4 Mar 2024)

Thanks; that's helpful. The exercises here hadn't covered regular expressions yet, but I'm very comfortable with using regex from other languages, so that's fine.

I'm not sure what you meant about setting internal state in `initialize`. Setting `@line = line` is essentially from the exercise; what other internal state did you have in mind?

### kotp (8 Mar 2024)

The diff from Iteration 1 to Iteration 2 (I1..I2):

```diff
diff --git a/log_line_parser.rb b/log_line_parser.rb
index 0e5e9e8..266d643 100644
--- a/log_line_parser.rb
+++ b/log_line_parser.rb
@@ -1,17 +1,24 @@
 class LogLineParser
+  LOG_LEVEL_PATTERN = /(?<=\[)([[:upper:]]+)(?=\]:)/
+  MESSAGE_PATTERN = /[\[\][:upper:]]+: (.+)/
+
   def initialize(line)
     @line = line
   end

   def message
-    @line.split(':')[1].strip
+    log_line = @line
+    match = MESSAGE_PATTERN.match(log_line)
+    return match.captures[0]&.strip
   end

   def log_level
-    @line.split(':')[0].downcase.slice(1..-2)
+    log_line = @line
+    match = LOG_LEVEL_PATTERN.match(log_line)
+    return match.captures[0]&.strip&.downcase
   end

   def reformat
-    String.new("#{message} (#{log_level})")
+    "#{message} (#{log_level})"
   end
 end
```

It looks like other trailing white space was introduced, making for a noisy diff.

But, we seem to be using the match backward?

Does this make better sense, because the pattern is the thing we want to match.

```ruby
log_line.match MESSAGE_PATTERN
```

I am not a fan of the `_PATTERN` part of the name. We do not do the same for our instance variables, for example `@line_string` just does not happen. Why does it feel like we have to give a "type indicator" in the name for the constant?

I will often create a "dictionary" of regular expressions.

----

What I would do for the two regular expressions is something like this:

```ruby
REGULAR_EXPRESSION = {
    level: /(?<=\[)([[:upper:]]+)(?=\]:)/,
    message: /[\[\][:upper:]]+: (.+)/
}
```

I would notice that this is rather long, and so would be tempted to use an abbreviation. However, I am all in for "responsible abbreviation use".

That means that I will do something like this:

```ruby
RE = REGULAR_EXPRESSION = {
    level: /(?<=\[)([[:upper:]]+)(?=\]:)/,
    message: /[\[\][:upper:]]+: (.+)/
}

private_constant :RE
```

This can now be used like expected:

```ruby
line.match RE[:level]
```

----

Internal state in our case is probably the `log_level` and `message`.

Instead of setting up `@line` (preferably getting to it by calling line, from `attr_reader :line`).

----

I am looking forward to the next iteration!

## Iteration 3was submitted (8 Mar 2024)

### owenblacker (8 Mar 2024)

Aha, that makes complete sense about using the regex backwards — I looked up `Regex.match` and didn’t think to check if I could do `String.match(Regex)` instead. Thank you; that is clearer.

I do like that dictionary of regex approach; nice and tidy.

Not having completed this exercise is blocking me from moving further, so I’m gonna mark this as complete and maybe come back to the further refinement once I’ve got a better basis in Ruby.

Thank you so much for your help!

### kotp (9 Mar 2024)

Absolutely. You can always hit "End discussion", while that does not necessarily need to actually end the discussion.

The diff from I2..I3:

```diff
diff --git a/log_line_parser.rb b/log_line_parser.rb
index 266d643..7f6d6b9 100644
--- a/log_line_parser.rb
+++ b/log_line_parser.rb
@@ -1,20 +1,23 @@
 class LogLineParser
-  LOG_LEVEL_PATTERN = /(?<=\[)([[:upper:]]+)(?=\]:)/
-  MESSAGE_PATTERN = /[\[\][:upper:]]+: (.+)/
+  REGEX = {
+    level: /(?<=\[)([[:upper:]]+)(?=\]:)/,
+    message: /[\[\][:upper:]]+: (.+)/
+  }
+  private_constant :REGEX
+  attr_reader :line

-  def initialize(line)
-    @line = line
+  def initialize(input_line)
+    @line = input_line
   end

   def message
-    log_line = @line
-    match = MESSAGE_PATTERN.match(log_line)
+    # debug "`@line`: #{@line}, `:line`: #{:line}, `line`: #{line}"
+    match = line.match REGEX[:message]
     return match.captures[0]&.strip
   end

   def log_level
-    log_line = @line
-    match = LOG_LEVEL_PATTERN.match(log_line)
+    match = line.match REGEX[:level]
     return match.captures[0]&.strip&.downcase
   end
```

It appears that trailing white space is not being introduced, but also not being attended to.

Using an abbreviation should be a decision that is not lightly taken.

The `REGEX` makes me have to remember "Are we using RE, RGXP, REGEX, REGEXP, or what?" Instead, I tend to use abbreviations in a "responsible" way. After all, while INAALINAHIMH, I do use them, and it is very helpful when they are defined on first, and when not used for a while, on near use. Otherwise, even if both parties think "Oh, that is a very common acronym, I know what is being communicated." there is less chance of it being two different things.

For example: `msg`, every one knows this, and so we can all assume I am talking about monosodium glutamate. Oh, wait, you mean you wanted me to provide not monosodium glutamate, but a message? Ah, my apologies. But why, then, did we not just say so? Or define that on near use?

Also, in a multi-culture and multi-lingual environment, such as programming, we need to be careful since what is a word, such as "num" or "no", in full, is also sometimes used as an abbreviation. It is just easier to use `number` and that can be looked up in a dictionary and understood clearly at that point if that word is not familiar to the reader that may not have "English" as their first language.

----

We should remove the explicit returns, when we are not modifying the behavior of a method. Reserve the use of explicit returns for when we need to have an early return.

----

If you need to use `debug` you can leave it in the code. I am trying to figure out what we should guard it with though. Where did you learn that you could use `debug`? It is surely helpful.

This is how I would avoid needing to remember to comment it out, so that local runs do not fail:

```ruby
defined?(Kernel.debug) and
  debug "`@line`: #{@line}, `:line`: #{:line}, `line`: #{line}"
```

This way, when it is pulled down to local development it will not raise an exception.

An additional check could be set based on `$DEBUG` or `$VERBOSE` if you wanted to manipulate that in the source code directly without having to touch each line where `debug` is used.

----

What do you think of this? How can we do the same for the log level?

```ruby
private

attr_reader :line

def initialize(input_line)
    @line = input_line
    @message = line.match( REGEX[:message]) .captures[0]&.strip
end

public

attr_reader :message
```

This also makes `line` method a private method since it is not intended for public access.

----

Do not forget to explore the "template" methods `Kernel#format`, its alias `Kernel#sprintf` and my go-to `String#%` which I pronounce as "string format".

The reason I prefer this (`String#%`) over the other two method names is that this is a `String` method, and I think it feels strange to reach for `Kernel` when formatting a `String`. Sure, we use the `Kernel` method named puts to output a string, but we do not have a method on String that will do the same thing, really. And it does more than just operate with String objects, and so it has a broader reach.

----

I am looking forward to the next iteration!
