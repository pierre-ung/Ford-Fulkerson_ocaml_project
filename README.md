# 4IR - INSA Toulouse - OCaml - Mini Project 

Nous avons atteint le **Medium project** en implémentant la résolution du problème de *money sharing*
## Sommaire
[Etudiants](Etudiants)

## Etudiants (Groupe 4IR-C1) : 
* Loic ROBERT
* Pierre UNG

## Fonctionnalités
* Maximisation de flots de graphes (Algorithme de Ford-Fulkerson) totalement fonctionnel
  * Entrée: 
       - Un graphe orienté avec flots maximum de chaque arc au format texte
       - Un noeud source 
       - Un noeud puit
  * Sortie: Le graphe d'entrée avec les flots maximisés, au format texte et .dot (pour pouvoir le     convertir en image .svg)
* Résolution du problème "money sharing" (qui utilise aussi Ford-Fulkerson)
  * Entrée: Une liste d'association Nom Somme_payé (où Somme_payé est un entier)
  * Sortie: Un fichier texte montrant combien chacun doit aux autres pour que tout le monde ai payé la même somme

## Utilisation

Build les 2 éxécutables: 
```bash
make build
```

### Maximisation de flots (Ford-Fulkerson)

#### Démonstration

Pour lancer la démonstration :
```bash
make demo_ff
```


#### Utilisation libre

Format d'un graphe d'entrée (exemple, vous pouvez générer un graphe [ici](https://www-m9.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html)): 
```c
%% Nodes

n 88 209     % This is node #0, with its coordinates (which are not used by the algorithms).
n 408 183
n 269 491
n 261 297
n 401 394
n 535 294    % This is node #5.


%% Edges

e 1 3 11     % An edge from 3 to 1, labeled "11".
e 3 1 4
e 3 2 2
e 1 5 22
e 4 5 14
e 4 1 1
e 0 1 7
e 0 3 10
e 3 4 5
e 2 4 12
e 0 2 8
```

Build l'éxécutable ftest.native:
```bash
make build_ff
```

Lancer ftest.native:
```bash
./ftest.native graphe_source noeud_source noeud_puit fichier_de_sortie
```

Pour convertir fichier_de_sortie.dot en image:
```bash
dot -Tsvg fichier_de_sortie.dot > fichier_de_sortie.svg
```

### Money sharing

#### Démonstration

Pour lancer la démonstration :
```bash
make demo_ms
```

#### Utilisation libre

Format d'une liste d'entrée (exemple): 
```bash
% Format: n <Nom> <Somme donnée>
% Ceci est un commentaire 
n Pierre 40
n Loic 40
n Julien 70
n Moi 40
```

Build l'éxécutable share_money_test.native:
```bash
make build_ms
```

Lancer share_money_test.native:
```bash
./share_money_test.native fichier_entrée fichier_sortie
```
Le résultat se trouve dans le fichier_sortie.txt sous la forme:
```bash
x1 owes y$ to x2
...
```

## Tests
Les tests que nous avons effectués sont disponibles dans */test_set*
### Ford Fulkerson.
* Les graphs d'entrée et de sortie au format texte sont disponibles dans */Ford_Fulkerson*.
* Les graphes de sortie (avec les flots maximisés) au format .svg sont disponibles dans */Ford_Fulkerson/solved_graph_images*.

### Money sharing
* Les listes d'entrée et leur solutions au format texte sont disponibles dans */money_sharing*.
* Les graphes associés aux solutions sont disponibles dans */money_sharing/graphs*.
