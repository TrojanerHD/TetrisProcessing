ArrayList<Tile> lockedTiles = new ArrayList();
TileCollection tc = new TileCollection();
int count = 0;

void setup() {
    size(350, 700);
    background(0);
    Background bg = new Background();
    bg.draw();
    tc.generateRandomTile();
}

void draw() {
    if (count < 60) count++;
    else {
        tc.moveTiles(Direction.DOWN);
        if (tc.locked) {
            for (Tile tile: tc.tiles) lockedTiles.add(tile);
            tc = new TileCollection();
            tc.generateRandomTile();
        }
        count = 0;
    }
    for (int i = 0; i < lockedTiles.size(); i++) {
        Tile tile = lockedTiles.get(i);
        ArrayList<Tile> sameCoordinates = new ArrayList(lockedTiles);
        sameCoordinates.removeIf(
        );
        if (sameCoordinates.size() == 1) {
            lockedTiles.remove(i);
            return;
        }
        tile.printSquare();
    }
}

void keyPressed() {
    switch (key) {
        case 'a':
            tc.moveTiles(Direction.LEFT);
            break;
        case 'w':
            while(!tc.locked) tc.moveTiles(Direction.DOWN);
            break;
        case 's':
            tc.moveTiles(Direction.DOWN);
            break;
        case 'd':
            tc.moveTiles(Direction.RIGHT);
            break;
        default:
            return;
    }
    for (Tile tile: lockedTiles) tile.printSquare();
}
