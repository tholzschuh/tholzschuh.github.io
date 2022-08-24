---
title: "Using espanso to conveniently type unicode characters"
date: 2022-08-23
tags: ["espanso", "math", "unicode"]
type: "post"
showTableOfContents: false
---

[Peter Haine](https://math.berkeley.edu/~phaine/) recently made me aware of the possibility of using a ```text expander``` to conveniently type unicode characters like Π, ⟶ and 𝒞 by typing things like ```:Pi:```, ```:to:``` and ```:scC:```.

After a quick search for available options, I decided to give [```espanso```](https://espanso.org/) a try.

While the official [package hub](https://hub.espanso.org/) offers some packages with snippets relevant to mathematicians, I wasn't really satisfied with any of the available options and instead started adding all the symbols I might need manually.


# demonstration

![demo](/images/espanso_demo.gif)

# supported symbols

Currently, I implemented snippets for stuff like the following:

| Type | Examples | Type | Example
| ------- | ------- | ------- | ------- | 
| mathbf | 𝐀, 𝐁, 𝐂, ... | greek letters | γ, Γ, δ, Δ, ... |
| mathcal | 𝓐, 𝓑, 𝓒, ... | subscripts | Xₐ, X₁, ... |
| mathsf | 𝖠, 𝖡, 𝖢, ... | superscripts | Xᵃ, X¹, ... |
| mathsc | 𝒜, 𝒞, 𝒟, ... |  various arrows | ⟶, ↠, ⮩, ⇉, ⇶, ... |
| mathbb | 𝔸, 𝔹, ℂ, ... |  miscellaneous | ∞, ×, ∩, ∪, ... |


# ```tholzschuh-maths```

In case you want to try it for yourself, I packaged the whole thing and published it as the [```tholzschuh-maths```](https://hub.espanso.org/tholzschuh-maths) extension on the package hub.

A detailed overview of all available snippets can be found in the [README](https://github.com/espanso/hub/blob/main/packages/tholzschuh-maths/0.1.0/README.md) file.

To install the extension, simply type ```espanso install tholzschuh-maths``` in a terminal (which of course requires that you've already installed ```espanso``` itself).

## contributing

If you'd like to have other mathematical symbols supported or have anything else to report, either contact me or submit a pull request at the GitHub [repo](https://github.com/tholzschuh/hub/tree/main/packages/tholzschuh-maths/).

Enjoy!