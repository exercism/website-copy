# do not change given signatures

As the instructions mention, you should not modify the signatures of `makeChest` and `makeTreasureChest`.
They should remain exactly:

```elm
makeChest : String -> treasure -> Chest treasure {}

makeTreasureChest : Chest treasure { conditions | securePassword : (), uniqueTreasure : () } -> TreasureChest treasure
```
