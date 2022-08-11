---
title: "tikzcd snippets for VS Code"
date: 2022-08-11
tags: ["vscode", "latex", "tikzcd", "snippets"]
type: "post"
showTableOfContents: false
---

For writing LaTeX documents, I use [VS Code](https://code.visualstudio.com/) together with the [```latex-workshop```](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension.

One thing I particularly like about VS Code is its built-in support for [snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets) and how easy it is to implement your own.

As there aren't any extensions in the [marketplace](https://marketplace.visualstudio.com/vscode) providing snippets for commutative diagrams, I implemented some using ```tikz-cd``` on my own:

# Demonstration

This is what using the snippets looks like:

![snippet](/images/latex-snippets_demo.gif)
<details>
<summary>
Result:
</summary>

![result](/images/latex-snippets_diagram.png)
</details>

I cycle through the preselected ```X```, ```Y```, ```S```, ```T``` by pressing ```tab```, which makes it very convenient to change the objects' names appearing in the diagram.


# [```snippets-tikzcd```](https://marketplace.visualstudio.com/items?itemName=tholzschuh.snippets-tikzcd)

In case you want to try it for yourself, I packaged the whole thing and published it as the [```snippets-tikzcd```](https://marketplace.visualstudio.com/items?itemName=tholzschuh.snippets-tikzcd) extension.

To install the extension, simply go to ```File ⟶ Preferences ⟶ Extensions```, search for ```snippets-tikzcd``` and install.
If you for some reason dislike using the marketplace, you can also find the plugin in the ```versions``` folder of [this](https://github.com/tholzschuh/snippets-tikzcd) GitHub repository.

## supported diagrams

Here's the kinds of diagrams the extension currently supports:

- (pushout/pullback) ```square```s
- ```triangle```s
- ```cube```s
- (short/split/long) exact ```sequence```s and the 'snake'
- equalizers and reflexive parallel ```pair```s
- (augmented) (co-)```simplicial``` objects
- ```adjunction```s and natural ```transformation```s

Read the above as ```trigger``` triggers the drop-down menu to select all the varieties of diagrams of shape ```trigger``` (as in the demo).

Note that, in the future, the above list might not be comprehensive anymore if I end up adding some other diagrams.
I'll try to always keep the information on the [overview page](https://marketplace.visualstudio.com/items?itemName=tholzschuh.snippets-tikzcd) of the extension up-to-date.

## contributing

If you'd like to have other types of diagrams supported or have anything else to report, either contact me or submit a pull request at the GitHub [repo](https://github.com/tholzschuh/snippets-tikzcd).

Enjoy!











