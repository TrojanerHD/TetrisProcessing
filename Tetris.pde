ArrayList<Tile> lockedTiles = new ArrayList();
TileCollection tc = new TileCollection();
TileCollection nextTile = new TileCollection();
int count = 0;
boolean pause = false;
boolean blockInput = false;
boolean playing = true;

void setup() {
    size(525, 700);
    Background bg = new Background();
    bg.draw();
    textSize(16);
    tc.generateRandomTile();
    nextTile.generateRandomTile();
    nextTile.locked = true;
    nextTile.shiftTiles(true);
}

void draw() {
    if (!playing) return;
    if (count < 60) count++;
    else {
        if(!pause) tc.moveTiles(Direction.DOWN);
        if (tc.locked) {
            for (Tile tile: tc.tiles) lockedTiles.add(tile);
            tc = new TileCollection(nextTile);
            nextTile = new TileCollection();
            nextTile.generateRandomTile();
            nextTile.locked = true;
            nextTile.shiftTiles(true);
            tc.shiftTiles(false);
            tc.checkForGameEnd();
        }
        count = 0;
    }

    HashMap<Integer, ArrayList<Integer>> y = new HashMap();
    for (Tile tile: lockedTiles) {
        if (!y.containsKey(tile.y)) y.put(tile.y, new ArrayList());
        y.get(tile.y).add(tile.x);
        tile.printSquare();
    }

    int yHeight = -1;
    for (Integer i: y.keySet())
        if (y.get(i).size() == 10) {
            yHeight = i;
            break;
        }
    
    if (yHeight != -1) {
        ArrayList<Tile> tempLockedTiles = new ArrayList();
        for (Tile tile: lockedTiles) {
            if (tile.y != yHeight) tempLockedTiles.add(tile);
            if (tile.y < yHeight) tile.setXAndY(tile.x, tile.y + STATIC.gridSize);
        }
        lockedTiles = tempLockedTiles;
        drawEverything();
    }
}

void keyPressed() {
    if (blockInput) return;
    if (!playing) {
        if (keyCode != 32) return;
        tc.generateRandomTile();
        nextTile.generateRandomTile();
        nextTile.locked = true;
        playing = true;
        nextTile.shiftTiles(true);
        return;
    }
    switch (keyCode) {
        case 65:
        case 37:
            tc.moveTiles(Direction.LEFT);
            break;
        case 87:
        case 38:
            blockInput = true;
            while (!tc.locked && playing) tc.moveTiles(Direction.DOWN);
            blockInput = false;
            break;
        case 83:
        case 40:
            tc.moveTiles(Direction.DOWN);
            break;
        case 68:
        case 39:
            tc.moveTiles(Direction.RIGHT);
            break;
        case 69:
            tc.rotateTile(true);
            break;
        case 81:
            tc.rotateTile(false);
            break;
        case 80:
            pause = !pause;
            return;
        default:
            return;
    }
    for (Tile tile: lockedTiles) tile.printSquare();
}

void drawEverything() {
    new Background().draw();
    for (Tile tile: lockedTiles) tile.printSquare();
    tc.drawTiles();
    nextTile.drawTiles();
}
