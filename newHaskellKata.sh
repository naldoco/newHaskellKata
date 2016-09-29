#!/bin/bash
# newHaskellKata.sh
# Usage: newHaskellKata.sh NameOfTheNewHaskellKata

# Aim: To start a new Haskell kata in few seconds using an old one.
#      The kata will be placed next to the other katas in its own directory.

# Please, set up the next two variables:
KATAROOT="$HOME/git/GITHUB"
KATABASE="Bowling"

echo "The $KATA_U kata is being prepared."
KATA_U=`eval "echo ${1} | sed 's/^./\u&/'"`  # NameOfTheNewKata. First letter to uppercase
KATA_L=`eval "echo ${1} | sed 's/^./\l&/'"`  # NameOfTheNewKata. First letter to lowercase
KATABASE_U=`eval "echo $KATABASE | sed 's/^./\u&/'"`  # NameOfTheBaseKata. First letter to uppercase
KATABASE_L=`eval "echo $KATABASE | sed 's/^./\l&/'"`  # NameOfTheBaseKata. First letter to lowercase

function doit()
{
mkdir "$KATA_U"
cp -R \
  $KATABASE_U/.cabal-sandbox/  \
  $KATABASE_U/src/ \
  $KATABASE_U/test/ \
  $KATABASE_U/$KATABASE_U.cabal \
  $KATABASE_U/.gitignore \
       "$KATA_U"

cd "$KATA_U"

mv $KATABASE_U.cabal "$KATA_U".cabal
mv src/$KATABASE_U.hs src/"$KATA_U".hs

sed -i "s/$KATABASE_U/$KATA_U/g" "$KATA_U".cabal

sed -i "s/$KATABASE_U/$KATA_U/g" src/"$KATA_U".hs
sed -i "s/$KATABASE_U/$KATA_U/g" test/Tests.hs

sed -i "s/$KATABASE_L/$KATA_L/g" src/"$KATA_U".hs
sed -i "s/$KATABASE_L/$KATA_L/g" test/Tests.hs

cabal sandbox init
cabal configure --enable-tests
}

cd $KATAROOT
doit
