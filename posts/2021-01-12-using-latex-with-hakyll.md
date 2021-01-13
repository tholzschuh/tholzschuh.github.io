---
title: Using LaTeX with Hakyll
author: Tim Holzschuh
tags: hakyll, latex
---
Since [Hakyll](https://jaspervdj.be/hakyll/) is tightly integrated with [Pandoc](https://pandoc.org/), it's easy to use LaTeX with Hakyll by enabling Pandoc's LaTeX compile features.
Most explanations I found online, like [this](http://travis.athougies.net/posts/2013-08-13-using-math-on-your-hakyll-blog.html) one, seem to be quite outdated though and they don't work verbatim.

The basic idea still is to set up a custom pandoc compiler using the
```haskell
pandocCompilerWith :: ReaderOptions -> WriterOptions -> Compiler (Item String)
```
function, but the internals used in the `WriterOptions` have changed.
Specifically, enabling several extensions at once is no longer passed around as a `Set Extension`, but there is a new data type `Extensions` introduced to handle several Extensions at once.

The following code seems to work for me:
```haskell
pandocMathCompiler =
    let mathExtensions    = extensionsFromList [Ext_tex_math_dollars, Ext_tex_math_double_backslash, Ext_latex_macros]
        defaultExtensions = writerExtensions defaultHakyllWriterOptions
        newExtensions     = defaultExtensions <> mathExtensions
        writerOptions     = defaultHakyllWriterOptions {
                              writerExtensions = newExtensions,
                              writerHTMLMathMethod = MathJax ""
                            }
    in pandocCompilerWith defaultHakyllReaderOptions writerOptions
```  

It's essentially doing the same thing, we just store the necessary math extensions inside the `Extensions` data type by using the `extensionsFromList` function and we append `defaultExtensions` with `mathExtensions` using the `<>` function (this is essentially `mappend`).

You of course still have to add the
```javascript
<script type="text/javascript"
        src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```
line in the template generating the `HTML <head>` element.
Then everything works as expected:
\\[ \\ln x = \\int_{-\\infty}^x \\frac 1 y \\, dy . \\]
