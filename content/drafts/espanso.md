---
title: "Using espanso to conveniently type unicode characters"
date: 2022-08-05
tags: ["nixos", "nix", "espanso", "math", "unicode"]
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



