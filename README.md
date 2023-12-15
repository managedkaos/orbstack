# orbstack

Notes and scripts for working with OrbStack servers

## Create and Configure a Server

Create:

```
orb create ubuntu node20
```

Configure:

```
orb -m node20 ./ubuntu-install-node20.sh
```

## Connect to a Server Via SSH

Connect:

```
ssh node20@orb
```

## List and Delete a Server

List:

```
orb list
```

Delete:

```
orb delete node20
```
