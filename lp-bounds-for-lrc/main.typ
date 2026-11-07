#import "@preview/typslides:1.3.4": *

#let dh = $d_H$
#let wth = $"wt"_H$
#let mul = "mul"
#let Aut = "Aut"

// Project configuration
#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Lato",
  font-size: 20pt,
  link-style: "color",
  show-progress: true,
)

// Front slide
#front-slide(
  title: "Multi-View LP Bounds for LRCs",
  subtitle: [Delsarte Linear Programming Bounds in Coding Theory],
  authors: "Po-Wei Lai",
  info: [],
)

#table-of-contents()

#title-slide[ Getting Started ]

#slide(title: "Background: Why Error-Correcting Codes?")[
  - *Communication over Noisy Channels*:
    - Digital data (series of `0`s and `1`s) transmitted across networks can experience *bit flips* due to noise.
  
  - *Core Idea*: Introduce controlled *redundancy* to detect and correct errors.
  
  - *Simple Example (Repetition Code)*:
    - Message `0` $arrow.r$ Send `000` | Message `1` $arrow.r$ Send `111`
    - If receiver gets `010`:
      - Distance to `000` is 1; Distance to `111` is 2.
      - Guess the original message was `000`.
]

#slide(title: "From the Example to the Language of Codes")[
  - The two allowed messages are a subset of all length-three binary strings:

  $
    C = {000, 111} subset.eq {0, 1}^3
  $
  // #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt)[
  //   #align(center)[$C = {000, 111} subset.eq {0, 1}^3$]
  // ]

  - The set $C$ is a *code*; each member is a *codeword*.
  - Its parameters are length $n = 3$, size $|C| = 2$, and minimum distance $d = 3$.

  *Connection:* choosing a small subset of all strings creates room between codewords, and that room is what lets us correct noise.
]

#slide(title: "Basic Definitions")[
  - *Definition 1.1 (Code & Codeword)* \
    Fix length $n >= 1$ and an alphabet $Sigma$. A *code* $C$ is a subset $C subset.eq Sigma^n$. Elements in $C$ are called *codewords*.
    - *Example*: $C = {"BAG", "ACE", "FED", "EGG"} subset.eq {"A",...,"G"}^3$.

  - *Practical Setup*:
    - Usually set $Sigma = FF_q$ (Finite Field with $q = p^m$) to utilize its *algebraic structure* (addition & multiplication).
    - If $q = 2$, $C subset.eq FF_2^n$ is a *binary code*.
]

#slide(title: "Distances & Minimum Distance")[
  Let $x, y in FF_q^n$, $C subset.eq FF_q^n$.

  - *Definition 1.2 (Hamming Distance)*:
    $
      dh (x, y) := |{j in {1, ..., n}: x_j eq.not y_j}|
    $

  - *Definition 1.3 (Hamming Weight)*:
    $
      wth (x) := dh (bold(0), x) = |{j : x_j eq.not 0}|
    $

  - *Definition 1.4 (Minimum Distance)*:
    $
      d_min (C) := min_(x, y in C, x != y) dh (x, y)
    $
    - Remark: $d_min (C)$ measures the *fault tolerance*: a code with distance $d$ can correct up to $floor((d-1)/2)$ errors.
]

#title-slide[ Classical Upper Bounds ]

#slide(title: "Why Study Upper Bounds?")[
  - *Problem*: \
    Fix $q, n, d$, given $C subset.eq FF_q^n$ with $d_min (C) >= d$, *how large can $|C|$ be?*
  
  - *Objectives*:
    - Evaluate code efficiency (Information Rate).
    - Prove whether a discovered code is largest (when bound is sharp).

  - *Classical Combinatorial Bounds*:
    - *Singleton Bound*: $|C| <= q^(n - d + 1)$
    - *Hamming (Sphere-Packing) Bound*: $|C| <= q^n / (sum_(j=0)^floor((d-1)/2) binom(n, j) (q-1)^j)$
    \
    - *Plotkin Bound* (for $d > (q-1)/q n$): $|C| <= (q d) / (q d - n(q - 1))$
]

#slide(title: "What Do Classical Bounds Lack?")[
  - *Limitation*:
    - Most classical bounds rely solely on *combinatorial counting* or *geometric volume* arguments.
    - They largely *ignore* the field arithmetic (additive and multiplicative group structures) of $FF_q^n$.

  - *Solution*:
    - *Delsarte's Linear Programming Bound* bridges Harmonic Analysis (Fourier Transform on finite groups) and Linear Programming to yield vastly superior bounds.
]

#title-slide[ Delsarte LP Bound ]

#slide(title: "Difference Distribution")[
  - Instead of looking at individual codewords, we study pair differences.

  - *Definition 3.1 (Difference Distribution)* \
    For $C subset.eq FF_q^n$ with $d_min (C) >= d$, define $a_C: FF_q^n arrow.r RR$ as:
    $
      a_C (x) := 1 / (abs(C)) abs({(y, z) in C^2 : y - z = x})
    $
    *(Intuition: Average number of codeword pairs with difference $x$.)*

  - *Key Properties*:
    1. $a_C (bold(0)) = 1$
    2. $a_C (x) >= 0$ for all $x in FF_q^n$
    3. $a_C (x) = 0$ for all $0 < wth(x) < d$
    4. $sum_(x in FF_q^n) a_C (x) = |C|$
]

#slide(title: "A Frequency View: Fourier Transform")[
  The difference distribution is a function on the additive group $FF_q^n$. Instead of treating every shift $x$ separately, we can ask how this function aligns with simple patterns across the group.

  - These patterns are *characters*: homomorphisms $chi: FF_q^n --> CC^times$. They play the role of frequency modes on a finite group.

  - For the difference distribution, this frequency view will reveal a non-negativity property and give us the key constraints for the LP.
]

#slide(title: "Properties of Characters")[
  - *Orthogonality*: \
    For characters $chi, psi: FF_q^n --> CC^times$:
    $
      sum_(x in FF_q^n) chi (x) overline(psi (x)) = cases(q^n", if " chi = psi, 0", otherwise").
    $
  - *Character parametrization*: \
    Every character $chi: FF_q^n --> CC^times$ is uniquely determined by some $u in FF_q^n$ via
    $
      chi_u (x) := exp((2 pi i)/p tr_(q/p)(sum_(j=1)^n u_j x_j))
    $
    for all $x in FF_q^n$. \
    We write $chi_u$ for the character corresponding to $u$.
]

// #slide(title: "Why Fourier Transform? An Engineering View")[
//   A sound recording may mix several notes. Fourier transform answers:
//   *which pitches are present, and how loud is each one?*

//   #align(center)[$s(t) = sin(2 pi 440 t) + 0.5 sin(2 pi 880 t)$]

//   The frequency view reveals peaks at $440$ Hz and $880$ Hz. An equalizer can adjust each peak separately.

//   - More generally, Fourier transform turns filtering (convolution) into multiplication, one frequency at a time:
//     $f * g quad arrow.r quad hat(f * g)(k) = hat(f)(k) hat(g)(k)$

//   - On a finite group, *characters* play the role of waves. Here, autocorrelation gives a nonnegative squared magnitude:
//     $hat(a_C)(chi) = 1 / (|C|) abs(sum_y bb(1)_C (y) overline(chi(y)))^2 >= 0$
// ]

#slide(title: "A Frequency View: Fourier Transform")[
  One can show that ${chi_u}_(u in FF_q^n)$ forms an orthogonal basis for the function space \
  ${FF_q^n --> CC}$.

  We can understand Fourier transform in $FF_q^n$ by such perspective:

  - *Definition 3.2 (Fourier Transform)* \
    For a function $f: FF_q^n --> CC$, its Fourier transform is just taking the coordinate of $f$ respect to ${chi_u}$:
    $ hat(f) (chi_u) := sum_(x in FF_q^n) f(x) overline(chi_u (x)) $
]

#slide(title: "Connection to Fourier Analysis")[
  - Notice that $a_C (x)$ can be rewritten as an *autocorrelation*:
    $
      a_C (x) = 1 / (|C|) sum_(y in FF_q^n) bb(1)_C (y) bb(1)_C (y - x)
    $
  
  - Applying Fourier Transform on Finite Abelian Group $FF_q^n$:
    $
      hat(a_C) (chi_u) = 1 / (|C|) abs(sum_(y in FF_q^n) bb(1)_C (y) overline(chi_u (y)))^2 >= 0
    $

  - *Fourier Non-negativity Constraint*:
    - The Fourier coefficients of $a_C$ are *always non-negative*!
  
  // - Study shows that the characters are of the form
  //   $chi_u (x) = exp((2 pi i)/p tr(sum_(j=1)^n u_j x_j))$
]

#slide(title: "Singleton-level LP Bound")[
  - We can formulate the code size bound as a *Linear Program*:
  
  #block(fill: rgb("f4f4f6"), inset: 10pt, radius: 4pt, width: 100%)[
    *Maximize*
    $
      sum_(x in FF_q^n) a(x)
    $
    *Subject to*
    - $a(bold(0)) = 1$
    - $a(x) >= 0, quad forall x in FF_q^n$
    - $a(x) = 0, quad forall x "with" 0 < wth(x) < d$
    - $hat(a)(chi_u) >= 0, quad forall u in FF_q^n$
  ]

  - *Computational Bottleneck*:
    - Number of variables = $q^n$ (Exponential!). Impractical when $n >= 10$.
]

#slide(title: "Dimension Reduction via Krawtchouk Polynomials")[
  - *Symmetry / Orbit Lumping*:
    Group elements with the same Hamming weight can be aggregated!
    $A_C (j) := sum_(wth(x) = j) a_C (x) = 1 / (|C|) |{(y, z) in C^2: dh(y, z) = j}|$
  
  - *Krawtchouk Polynomial*:
    Relates Fourier non-negativity directly to Hamming weights:
    $sum_(j = 0)^n A_C (j) K_k (j; n, q) >= 0, quad forall k in {0, ..., n}$ where
    $ 
      K_k (j; n, q) := sum_(ell = 0)^k (-1)^ell (q - 1)^(k - ell) binom(j, ell) binom(n - j, k - ell) 
    $

  - *Resulting Delsarte LP Bound*:
    - Variables reduced from $q^n$ to just *$n + 1$*!
    - Extremely efficient to solve numerically via LP solvers.
]

#slide(title: "The Delsarte LP: One Variable Per Distance")[
  For a code with minimum distance at least $d$, maximize the total distance-distribution mass:

  #block(fill: rgb("f4f4f6"), inset: 10pt, radius: 4pt, width: 100%)[
    *Maximize* 
    $
      sum_(j=0)^n A(j)
    $

    *Subject to*
    - $A(0) = 1$
    - $A(j) >= 0 quad (0 <= j <= n)$
    - $A(j) = 0 quad (1 <= j < d)$
    - $sum_(j=0)^n A(j) K_k (j; n,q) >= 0 quad (0 <= k <= n)$
  ]
  Each real code gives a feasible point, so the LP maximum is an upper bound on $|C|$.
]

#slide(title: "Delsarte LP Bound vs. Other Bounds")[
  - For binary codes:
  #table(
    columns: (0.5fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    inset: 7pt,
    align: center,
    gutter: 0pt, 
    stroke: none, 

    table.hline(stroke: 1.5pt), 

    table.header([$(n,d)$], [Delsarte LP], [Hamming], [Plotkin], [Singleton], [Exact Value]),

    table.hline(stroke: 0.8pt), 

    [], [], [], [], [], [], 
    [$(5,3)$], [$4$], [$5$], [$6$], [$8$], [$4$], 
    [$(7,4)$], [$8$], [$16$], [$8$], [$16$], [$8$], 
    [$(9,4)$], [$25$], [$51$], [$-$], [$64$], [$20$], 
    [$(11,4)$], [$85$], [$170$], [$-$], [$256$], [$72$], 
    [$(13,4)$], [$292$], [$585$], [$-$], [$1024$], [$256$], 
    [], [], [], [], [], [], 

    table.hline(stroke: 1.5pt), 
  )
  // #cols(columns: (1fr, 1fr), gutter: 1.5em)[
  //   *Advantages*:
  //   - *Exact Computability*: Solvable in polynomial time w.r.t $n$.
  //   - *Tightness*: Strictly tighter than Singleton and Hamming bounds in most non-trivial parameters.
  // ][
  //   *Comparison Chart*:
  //   - For binary codes:
  //     #table(
  //     columns: (0.5fr, 0.8fr, 0.8fr),
  //     inset: 2pt,
  //     align: center,
  //     gutter: 8pt, 
  //     stroke: none, 

  //     table.hline(stroke: 1.5pt), 

  //     table.header([$(n,d)$], [Multi-view], [Witness]),

  //     table.hline(stroke: 0.8pt), 

  //     [], [], [],
  //     [$(2,5)$], [$4$], [$4$],
  //     [$(2,9)$], [$8$], [$8$],
  //     [$(3,5)$], [$9$], [$9$],
  //     [$(4,7)$], [$112$], [$64$],
  //     [$(4,5)$], [$16$], [$16$],
  //     [], [], [],

  //     table.hline(stroke: 1.5pt), 
  //   )
  // ]
]

#slide(title: "Why Start with the Full Group-Algebra LP?")[
  *Start with one variable for every difference*: This group-algebra view keeps the full pattern; we can merge variables later when structure permits.

  #align(center)[
    $a(x) quad arrow.r^("same Hamming weight") quad A(j) = sum_(wth(x)=j) a(x)$
  ]

  For availability, keep repair-view distances instead of merging them away:
  $Z(t_1,t_2,j,k,c,b)$

  *Principle:* start with the richest model; aggregate only what the code structure lets us identify.
]

#title-slide[ Locally Recoverable Codes (LRCs) ]

#slide(title: "Why Locally Recoverable Codes?")[
  - *Distributed Storage Problem*:
    - Modern cloud storage (e.g., Google File System, AWS S3) stores petabytes of data.
    - Standard codes require reading $O(k)$ nodes to repair *a single broken node* $arrow.r$ High I/O overhead.

  - *Local Recovery Goal*:
    - Repair any corrupted symbol by reading only a *small set $r << k$* of other symbols (Local View).

  - *Availability*:
    - Multiple disjoint repair sets for parallel recovery and high request traffic handling.
]

#slide(title: "Local-distance Availability")[
  Given $C subset.eq FF_q^n$ with $d_min (C) >= d$ and $r >= 1, delta >= 2, a >= 1$. \
  - *Definition 4.1* \
    The code $C$ has all-symbol local-distance $(r, delta, a)$-availability if, for every coordinate $i$, we can choose $a$ views

    #align(center)[$T_(i,h) = {i} union S_(i,h), quad h=1,...,a$]

    such that
    - $|T_(i,h)| <= r + delta - 1$,
    - the projected code $C|_(T_(i,h))$ has minimum distance at least $delta$,
    - the helper sets $S_(i,1),...,S_(i,a)$ are pairwise disjoint.

  Since $delta >= 2$, each view can recover an erased coordinate from the other symbols in that view. This local-distance condition is stronger than functional recovery alone.
]

#slide(title: "Partition around Each Coordinate")[
  For two available views, fix a coordinate $i$ and split all coordinates into four disjoint blocks:

  // #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt)[
  //   #align(center)[
  //     $S_(i,1)$ #h(0.5em) $S_(i,2)$ #h(0.5em) ${i}$ #h(0.5em) $O_i$
  //   ]
  //   #align(center)[$[n] = S_(i,1) union S_(i,2) union {i} union O_i$]
  // ]
  $
    S_(i,1) #h(1em) S_(i,2) #h(1em) {i} #h(1em) O_i \
    [n] = S_(i,1) union.sq S_(i,2) union.sq {i} union.sq O_i
  $

  For an ordered pair of codewords $(x,y)$, record four distances:
  - $j = d_(S_(i,1)) (x,y)$ and $k = d_(S_(i,2)) (x,y)$,
  - $b = 1_(x_i != y_i)$ and $c = d_(O_i) (x,y)$.

  These satisfy the exact identity $dh (x,y) = j+k+b+c$.
]

#slide(title: "The Multi-view Distribution")[
  Let $M = |C|$, and $u = t_1+t_2-1$. Average over ordered pairs and recovered coordinates:

  // #block(fill: rgb("f4f4f6"), inset: 10pt, radius: 4pt)[
  //   #align(center)[$Z_C (t_1,t_2,j,k,c,b) = 1/(n M) |{(x,y,i): |T_(i,h)|=t_h, d_(S_(i,1)) (x,y)=j, d_(S_(i,2)) (x,y)=k, d_(O_i) (x,y)=c, 1_(x_i != y_i)=b}|$]
  // ]
  $
    Z_C (t_1,t_2,j,k,c,b) = 1/(n M) abs({(x,y,i): mat(delim: #none, |T_(i,1)|=t_1", ", |T_(i,1)|=t_2", ", ; 
    d_(S_(i,1)) (x,y)=j", ", d_(S_(i,2)) (x,y)=k", ", ; 
    d_(O_i) (x,y)=c", ", 1_(x_i != y_i)=b) })
  $

  - The index $b$ separates pairs that agree or differ at the recovered coordinate.
  - The outside block has length $n-t_1-t_2+1$, so $0 <= c <= n-t_1-t_2+1$.
  - The global distance is already encoded: $ell = j+k+c+b$.
]

#slide(title: "Four Constraints")[
  #table(
    columns: (1.15fr, 2fr),
    align: left,
    inset: 9pt,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header([Constraint family], [What it enforces]),
    table.hline(stroke: 0.8pt),
    [Centering], [The local view counts must agree with the global distance distribution.],
    [Distance support], [Pairs cannot be too close globally or inside a local view.],
    [Product-Krawtchouk], [Every four-block frequency has nonnegative Fourier energy.],
    [Collisions], [Small local projections force many codeword pairs to agree there.],
    table.hline(stroke: 1.5pt),
  )
]

#slide(title: "The Actual Multi-view LP: Variables and Objective")[
  Fix $q,n,d,r,delta$ and $a=2$.

  #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt, width: 100%)[
    Variables
    - $Z(t_1,t_2,j,k,c,b) >= 0$ on admissible indices:
    - $delta <= t_1,t_2 <= min(n,r+delta-1), quad t_1+t_2-1 <= n$
    - $0<=j<t_1, quad 0<=k<t_2, quad 0<=c<=n-t_1-t_2+1, quad b in {0,1}$

    Global distribution
    - $A(ell) := sum_(t_1,t_2) sum_(j+k+c+b=ell) Z(t_1,t_2,j,k,c,b)$

    *Goal: Maximize* $sum_(t_1,t_2,j,k,c,b) Z(t_1,t_2,j,k,c,b) = sum_(ell=0)^n A(ell)$
  ]

  Each real code induces one feasible assignment of these variables.
]

#slide(title: "Subject to Global Counting")[
  For a pair at distance $ell$, exactly $ell$ of the $n$ possible recovered coordinates differ.
  The centered identities split the global mass according to $b$:

  #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt, width: 100%)[
    $sum_(t_1,t_2) sum_(j+k+c=ell) Z(t_1,t_2,j,k,c,0) = (n-ell)/n A(ell)$ \
    $sum_(t_1,t_2) sum_(j+k+c+1=ell) Z(t_1,t_2,j,k,c,1) = ell/n A(ell)$
  ]

  The global distance distribution also satisfies:
  #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt, width: 100%)[
    $A(0)=1,$ \ $A(ell)>=0 " for all "ell,$ \ $A(ell)=0 text(" for ") 1<=ell<max(d,delta)$
  ]
]

#slide(title: "Subject to Distance Support")[
  Short distances are forbidden by the global distance and the local-distance requirement.

  #block(fill: rgb("f4f4f6"), inset: 14pt, radius: 4pt, width: 100%)[
    *Local views* \
    $Z(t_1,t_2,j,k,c,b)=0 text(" if ") 1<=j+b<delta$ \
    $Z(t_1,t_2,j,k,c,b)=0 text(" if ") 1<=k+b<delta$

    *Global code distance* \
    $Z(t_1,t_2,j,k,c,b)=0 text(" if ") 1<=j+k+c+b<max(d,delta)$
  ]

  The first two conditions protect each repair view; the last excludes globally too-close codeword pairs.
]

#slide(title: "Subject to Product-Krawtchouk Positivity")[
  Every frequency tuple gives a nonnegative transform of the four-block distribution: \
  Let 
  $
    P(j,k,c,b) := & K_(p_1) (j;t_1-1,q) K_(p_2) (k;t_2-1,q) \
    & times K_eta (c;n-u,q) K_e (b;1,q)
  $
  We have: 
  #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt, width: 100%)[
    $Phi_C (t_1,t_2;p_1,p_2,eta,e) := sum_(j,k,c,b) Z_C (t_1,t_2;j,k,c,b) P(j,k,c,b) >= 0, "for"$ \
    \
    $0<=p_1<t_1, quad 0<=p_2<t_2, quad 0<=eta<=n-t_1-t_2+1, quad e in {0,1}$
  ]

  

  This is imposed for every admissible $(t_1,t_2)$ and every frequency tuple in these ranges.
]

#slide(title: "Why Does Locality Force Collisions?")[
  Project the $M$ codewords onto a length-$L$ set whose projected code has distance at least $delta$.
  Singleton says there are at most $q^(L-delta+1)$ distinct projections.

  If $f_z$ codewords have projection $z$, then Cauchy-Schwarz gives:

  $
    q^(L-delta+1) sum_z f_z^2 >= M^2
  $

  This is the normalized number of ordered pairs that *collide* on the projection.
  - Apply it to the first local view.
  - Apply it to the second local view.
  - Apply it to the union of both helper sets (with the recovered coordinate removed).
]

#slide(title: "Subject to Local Collision Inequalities")[
  Let $m(t_1,t_2)=sum_(j,k,c,b) Z(t_1,t_2,j,k,c,b)$ be the total mass for a fixed pair of view lengths.
  #block(fill: rgb("f4f4f6"), inset: 12pt, radius: 4pt, width: 100%)[
    *First local view* \
    $q^(t_1-delta+1) sum_(k,c) Z(t_1,t_2,0,k,c,0) >= m(t_1,t_2)$

    *Second local view* \
    $q^(t_2-delta+1) sum_(j,c) Z(t_1,t_2,j,0,c,0) >= m(t_1,t_2)$

    *Punctured union of helper sets* \
    $q^(t_1+t_2-delta-1) sum_c Z(t_1,t_2,0,0,c,0) >= m(t_1,t_2)$
  ]

  The first two rows use each full repair view; the last uses both helper sets with the recovered coordinate removed.
]

// #slide(title: "My Summer Research: Multi-View LP Bounds")[
//   - *Setting ($a=2$ Availability)*:
//     - Every coordinate $i$ has *2 disjoint repair sets* $S_(i,1), S_(i,2)$.
  
//   - *New Variables ($Y_C$ Distribution)*:
//     - Track global distance $ell$, local distances $j_1, j_2$, and overlap indicator $b$:
//     $Y_C (ell, t_1, t_2, j_1, j_2, b)$

//   - *Formulating Multi-View LP*:
//     - *Global-Local Distance Identities*
//     - *Multi-variable Krawtchouk Positivity Constraints*
//     - *Local Collision Inequalities*
// ]

#slide(title: "Result")[
  #table(
    columns: (0.5fr, 1fr, 1fr, 1fr),
    inset: 7pt,
    align: center,
    gutter: 0pt, 
    stroke: none, 

    table.hline(stroke: 1.5pt), 

    table.header([$(q,n,d,r,delta)$], [Multiview], [Delsarte], [Verified Code Size]),

    table.hline(stroke: 0.8pt), 

    [], [], [], [],
    [$(2,9,3,1,2)$], [$8$], [$42$], [$8$],
    [$(2,14,4,2,2)$], [$90.35$], [$512$], [$64$],
    [$(3,8,3,2,3)$], [$9$], [$340$], [$9$],
    [$(3,9,5,2,2)$], [$27$], [$90$], [$27$],
    [$(4,8,4,2,2)$], [$64$], [$614$], [$64$],
    [], [], [], [],

    table.hline(stroke: 1.5pt), 
  )
]

#slide(title: "Main Contributions")[
  + Extended classical Delsarte LP to high-dimensional local distance distributions.
  + Derived new upper bounds for $(r, delta, a=2)$-availability LRCs.
  + Implemented LRC LP bound for general $(q, n, d, r, delta, a)$.

\
  All the related files are uploaded on my GitHub repo: \
  https://github.com/poposaber/lp-bounds-for-lrc \
  \
  Also, our paper about this project is already published on ArXiv: \ 
  https://arxiv.org/abs/2609.39230
]



// #title-slide[ Appendix: Proof Sketches & Algebraic Foundations ]

// #slide(title: "Character Group of Finite Fields")[
//   - *Additive Character of $FF_p$*:
//     $hat(FF_p) = { chi_u (x) = e^((2 pi i)/p u x) : u in FF_p }$

//   - *Extension to $FF_q$ ($q=p^m$)*:
//     Using Absolute Field Trace $tr: FF_q arrow.r FF_p$:
//     $hat(FF_q) = { chi_u (x) = e^((2 pi i)/p tr(u x)) : u in FF_q }$

//   - *Extension to Vector Space $FF_q^n$*:
//     Via inner product $chevron.l u, x chevron.r = sum u_i x_i$:
//     $hat(FF_q^n) = { chi_u (x) = e^((2 pi i)/p tr(chevron.l u, x chevron.r)) : u in FF_q^n }$
// ]

// #let bib = bibliography("bibliography.bib")
// #bibliography-slide(bib)