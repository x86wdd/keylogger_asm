## README pour le Keylogger

# Keylogger en Assembly x86_64

Ce projet est un keylogger minimaliste écrit en assembleur pour Linux 64 bits. Il capture les événements clavier depuis un périphérique d’entrée (`/dev/input/eventX`) et les enregistre dans un fichier de log.

## Fonctionnalités
- Ouvre un périphérique d’entrée clavier (`/dev/input/event0` par défaut).
- Lit les événements clavier en continu.
- Écrit les codes des touches dans `/tmp/keylog`.
- Boucle infinie pour une capture persistante.

## Prérequis
- Un système Linux 64 bits.
- `nasm` et `ld` pour la compilation.
- Accès root (pour lire `/dev/input/eventX`).
- Identifier le bon périphérique clavier (ex. via `cat /proc/bus/input/devices`).

## Compilation
1. Sauvegarde le code dans `keylogger.asm`.
2. Assemble et linke avec :
   ```bash
   nasm -f elf64 keylogger.asm -o keylogger.o
   ld keylogger.o -o keylogger
   ```
3. L’exécutable `keylogger` est prêt.

## Utilisation
1. Exécute avec privilèges root :
   ```bash
   sudo ./keylogger
   ```
2. Tape des touches ; les codes sont enregistrés dans `/tmp/keylog`.
3. Arrête avec `Ctrl+C` ou tue le processus.

### Configuration
- Si `/dev/input/event0` ne correspond pas à ton clavier, modifie la chaîne dans `.data` (ex. `event1`) et recompile.

## Limitations
- Les codes des touches sont bruts (entiers 32 bits) et nécessitent un post-traitement pour être lisibles.
- Nécessite un accès root.
- Pas de gestion fine des erreurs (sortie simple en cas de problème).

## Exemple
```bash
sudo ./keylogger
# Tape "abc" au clavier
cat /tmp/keylog  # Vérifie les codes bruts
```

## Avertissement
Usage éducatif uniquement. Ne pas utiliser pour espionner sans consentement, ce qui est illégal dans de nombreux contextes.
