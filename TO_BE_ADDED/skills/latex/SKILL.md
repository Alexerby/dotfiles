---
name: latex
description: LaTeX formatting conventions for this thesis. Apply automatically when writing or editing any .tex file.
user-invocable: false
---

## Source Formatting

- One sentence per line in the source. Every new sentence starts on a new line.
- No semicolons. Break into two sentences instead.
- No em dashes (---) and no en dashes (--) as punctuation. Restructure the sentence instead.
- No colons before equations or lists unless the sentence would be ungrammatical otherwise.
- Avoid parenthetical asides. Fold the information into a direct sentence.

## Prose Style

- Lead with the claim or definition. Motivation follows, it does not precede.
- Prefer short, direct sentences. Never use three words where one works.
- Use \emph{} for the first introduction of a term or for logical emphasis. Do not italicise for decoration.
- Do not use words like "straightforward", "clearly", "obviously", or "it is worth noting".
- Academic but not stuffy. No filler phrases ("In order to", "It can be seen that").

## Math and Equations

- Display equations that are the main point of a paragraph. Keep incidental expressions inline.
- Wrap displayed equations with a blank `%` comment line above and below for spacing:
  ```
  %
  \begin{equation}
    ...
  \end{equation}
  %
  ```
- Use `\label{eq:...}` on every numbered equation and `\autoref{eq:...}` to refer to it.
- Notation must be consistent across the document. Pick one symbol for each object and never mix.
- Define every symbol in prose immediately after it appears. Do not assume the reader tracks earlier definitions.

## Citations and References

- Use `\textcite{key}` when the author is the grammatical subject: "Following \textcite{lipton_2013}, ..."
- Use `\parencite{key}` for parenthetical references at the end of a sentence.
- Use `\autoref{}` for all cross-references to figures, equations, sections, and appendices.

## Structure

- New subsections earn their place. Do not create a subsection for fewer than two meaningful paragraphs.
- `\textcolor{blue}{TODO: ...}` for in-progress notes. Never leave a TODO as a floating sentence fragment.
- Do not add comments or docstrings to code that was not changed.
