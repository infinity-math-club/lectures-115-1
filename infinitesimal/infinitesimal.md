---

---

follow the book:
A Primer of Infinitesimal Analysis, 2nd edition, John L. Bell,
https://www.cambridge.org/core/books/primer-of-infinitesimal-analysis/B0EF33F73CAF97C180897D2FD0AD1B6E

if you don't have the access to this book, you can try use this prompt to LLM:
```
A Primer of Infinitesimal Analysis, 2nd edition, John L. Bell,
in this book:
what is the motivation of microstraight?
what is the definition of infinitesimal?
why it don’t use the law of exclude middle?
what is the axioms it used for the smooth affine line, it is a field, and list out the 6 axiom for the order < on the it.
```

## Motivation

1. continuum
2. jump function, the law of exclude middle
3. area under a curve

continua vs continuum vs continuous?
position vs point?
identical (=) vs indistinguishable (¬¬=)
part vs subset?
processes vs function?

---

## Logic

In intuitionistic logic, we don't assume the law of exclude middle. 
But still have the inference rule for $and, or, ->, bot$ and $not A := A -> bot$. Consequently:

allow:
- $A → not not A$
- $(A → B) → (not B → not A)$
- $(not A or not B) → not (A and B)$
- $(not exists x. P(x)) → (forall x. not P(x))$

not allow
- law of exclude middle: $A or not A$
- double negation elimination: $not not A  → A$ 
- de morgen, nonconstructive or: $not (A and B) →  (not A or not B)$
- contrapositive, without positively witness of B: $(not B → not A) → (A → B)$
- nonconstructive existence: $(forall x. not P(x)) → (not exists x. P(x))$


---
## Quote 

> the ‘infinitely small’ or ‘infinitesimal’ quantities were vaguely conceived as being neither zero nor finite but in some intermediate, nascent or evanescent state.

intermediate, adjective, /ˌɪn.t̬ɚˈmiː.di.ət/
being between two other related things, levels, or points.

nascent, adjective, /ˈneɪ.sənt/
only recently formed or started, but likely to grow larger quickly.

evanescent, adjective, /ˌev.əˈnes.ənt/
lasting for only a short time, then disappearing quickly and being forgotten.

介在零與有限之間、萌芽、轉瞬即逝

> It is singular that nobody objects to √ − 1 as involving any contradiction, nor, since
> Cantor, are infinitely great quantities objected to, but still the antique prejudice against
> infinitely small quantities remains.

haha

---
## Axiom

R = (0, 1, +, ×, <) form a field

write
- ab := a × b
- a ≠ b := ¬ (a = b)
- a > b := b < a
- a - b := a + (-b)

in particular, we have
- 0 ≠ 1
- for all a ≠ 0, there exist a⁻¹, such that aa⁻¹ = 1

axiom about <
- ¬ (a < a)
- if a < b and b < c then a < c
- if a < b then a + c < b + c
- if a < b and 0 < c then ac < bc
- for all a, 0 < a or a < 1
- if a ≠ b then a < b or a > b

define a ≤ b := ¬ (a > b)

notice we don't assume $forall a, b, a = b or a ≠ b$ and $forall a, b, a < b or not (a < b)$.

---
## Warning

in a field, to prove
if ab = 0 then a = 0 or b = 0
needs the law of exclude middle.

---

## Exercise

R is a field

(1) a < b and b < c implies a < c. 
(2) not a < a. 
(3) a < b implies a + c < b + c for any c. 
(4) a < b and 0 < c implies ac < bc. 
(5) either 0 < a or a < 1. 
(6) a = b implies a < b or b < a

### 1.1 Prove the following:
#### Show that 0 < a implies 0 ≠ a; 

Let 0 < a.
Assume 0 = a.
Then 0 < 0. 
Contradiction to (2)

#### 0 < a iff −a < 0; 

→ 
Let 0 < a.
-a = 0 + -a < a + -a = 0
so -a < 0.

← ...

#### 0 < 1 + 1; 

0 < 1 
1 < 1 + 1
0 < 1 < 1 + 1

#### (a < 0 or 0 < a) implies 0 < a²

case a < 0
a < 0
0 < -a
0 < (-a)^2 = a^2

case 0 < a → ...


### 1.2 Show that, if a < b, then, for any x, either a < x or x < b.

since b - a > 0
let y = (x - a)/(b - a)
by (5), case 0 < y or y < 1

case 0 < y = (x - a)/(b - a)
...
a < x

case y = (x - a)/(b - a) < 1
...
x < b


### 1.3 Show that (a, b) is empty iff not a < b
x ∈ (a, b) := a < x and x < b


 (a, b) is empty
 iff
 ∀ x, ¬ (a < x and x < b)
...

check a < (a + b)/2 < b if a < b.

### 1.4 Show that ≤ satisfies the following conditions: 

#### x ≤ y and y ≤ z implies x ≤ z 
x ≤ y and y ≤ z implies ¬(x > z)

Let x ≤ y, y ≤ z.
Assume x > z.
by 1.2, case x > y or y > z

...
Contradiction.

 
[CLASSICALLY]

x ≤ y → x = y or x < y

By the law of exclude middle.
case x = y or x ≠ y
case x = y, done
case x ≠ y, 
by (6), case x < y, x > y
case x < y, done
case x > y, contradiction to x ≤ y.


Let x ≤ y, y ≤ z.
Assume x > z.

...
Contradiction.


[\CLASSICALLY]

#### x ≤ x 
⇔ ¬ (x < x)

#### x ≤ y implies x + z ≤ y + z 
not (x > y) implies not (x + z > y + z)
x ≤ y and 0 ≤ t implies xt ≤ yt 

#### 0 ≤ 1 
by 0 < 1




#### x ≤ y and 0 ≤ t implies xt ≤ yt 

compare
x ≤ y → x = y or x < y
x = y or x < y → x ≤ y
x ≤ y and x ≠ y → x < y

### 1.6 Show that, for all ε in Δ, 

define $Delta = {x | x^2 in epsilon}$

[CLASSICALLY]
if x ² = 0 

case x = 0, done
case x ≠ 0, x = x² x⁻¹ = 0, contradiction.

[\CLASSICALLY]

at least, we get $forall epsilon in Delta, not not(epsilon = 0)$.

#### (i) not (ε < 0 or 0 < ε), 

#### (ii) 0 ≤ ε and ε ≤ 0, 

Assume 0 > ε, ..., contradiction
...

#### (iii) for any a in R, ε a is in Δ, 


#### (iv) if a < 0, then a + ε < 0.


a + ε ≤ a + 0 < 0

a ≥ b > c → a > c
a ≥ b ≥ c → a ≥ c
if a = c then c ≥ b > c, ⊥
so a ≠ c


### 1.7 Show that for any a, b in R and all ε, η in Δ, [a, b] = [a + ε, b + η].Deduce that [a, b] is microstable.

a ≤ x ≤ b

a = a + 0 ≤ a + ε ≤ x + ε ≤ b + ε ≤ b + 0 = b

---

## indistinguishable 

a ≤ b and a ≥ b ⇔ not (a ≠ b)
→ 
assume a ≠ b
by axiom, a < b or a > b
case a < b, contradiction to a ≥ b
case a > b, contradiction to a ≤ b
in each case, we get contradiction
so not (a ≠ b).
← 
assume a > b
by irreflexivity, a ≠ b, contradiction with not (a ≠ b)
so a ≤ b
assume a < b
by irreflexivity, a ≠ b, contradiction with not (a ≠ b)
so a ≥ b


a, b are indistinguishable := ¬¬(a = b)

+, × is well defined on indistinguishable
<, ≤ is well defined on indistinguishable

i.e. if a, a' are indistinguishable, b, b' are indistinguishable then
- a+b, a'+b' are indistinguishable
- ab, a'b' are indistinguishable
- a < b iff a' < b'
- a ≤ b iff a' ≤ b'

--- 

Truly interesting axioms and theorem:
### Axiom (Principle of Microaffineness) 
For any map $g: Δ → R$, there exists a unique $b$ in $R$ such that, for all $ε$ in $Delta$, we have
$$g(ε) = g(0) + b.ε$$. This says that the graph of $g$ is a straight line passing through $(0, g(0))$ with slope $b$.

### Theorem (Principle of Microcancellation) 
$Delta$ satisfies the Principle of (Universal) Microcancellation, namely, for any $a, b$ in $R$, $$"if" ε a = ε b "for all" ε in Delta , "then" a = b$$. In particular, if $ε a = 0$ for all $ε$ in $Delta$, then $a = 0$.


## Axiom (Constancy Principle)
Constancy Principle may be equivalently expressed in the form: 

if $f$: $J → R$ satisfies $f (x + ε) = f (x)$ for all $x$ in $J$ and all $ε$ in $Delta$
– that is, if every point in the domain of $f$ is a stationary point – 
then $f$ is constant.

(In the remainder of this text we shall use the symbol $J$ to denote an arbitrary closed interval or $R$ itself)

## Theorem (Extended Microcancellation Principle) 
Given $(a_1, . . . , a_n )$ in $R^n$, suppose that $∑^n_(i=1) ε_i a_i = 0$ for any n-microvector $(ε_1, . . . , ε_n)$. Then $a_i = 0$ for all $i = 1, . . . , n$.

## Axiom (Integration Principle) 
For any $f: [0, 1] → R$ there is a unique $g: [0, 1] → R$ such that $g′ = f$ and $g(0) = 0$.
(we can use it to prove the Constancy Principle)

## Theorem (All function are continous)
For all $f : R → R$ , $f$ is continuous, where $f$ is continuous is defined to mean $∀ x ∈ R, ∀ y ∈ R, (x − y ∈ Delta → f (x) − f (y) ∈ Delta)$.






