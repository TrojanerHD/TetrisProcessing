class TileCollection {
    ArrayList<Tile> tiles = new ArrayList<Tile>();
    boolean locked = false;

    void generateRandomTile() {
        switch (Math.round(random(6f))) {
            case 0:
                for (int y = 0; y < 4; y++)
                    tiles.add(new Tile(0, y, TileColor.LIGHT_BLUE));
                break;
            case 1:
                for (int y = 0; y < 3; y++) {
                    tiles.add(new Tile(0, y, TileColor.DARK_BLUE));
                    if (y == 2) tiles.add(new Tile(1, y, TileColor.DARK_BLUE));
                }
                break;
            case 2:
                for (int y = 0; y < 3; y++) {
                    tiles.add(new Tile(1, y, TileColor.ORANGE));
                    if (y == 2) tiles.add(new Tile(0, y, TileColor.ORANGE));
                }
                break;
            case 3:
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++) 
                        tiles.add(new Tile(x, y, TileColor.YELLOW));
                break;
            case 4:
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++)
                        tiles.add(new Tile(y != 0 ? x : x + 1, y, TileColor.GREEN));
                break;
            case 5:
                for (int y = 0; y < 2; y++)
                    if (y == 0) tiles.add(new Tile(1, y, TileColor.PURPLE));
                    else for (int x = 0; x < 3; x++) tiles.add(new Tile(x, y, TileColor.PURPLE));
                break;
            case 6:
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++)
                        tiles.add(new Tile(y != 0 ? x + 1 : x, y, TileColor.RED));
                break;
            default:
                println("Hello World");
                break;	
        }
    }

    void moveTiles(Direction direction) {
        int moveX = 0;
        int moveY = 0;
        switch (direction) {
            case LEFT:
                moveX = -1;
                break;
            case UP:
                moveY = -1;
                break;
            case DOWN:
                moveY = 1;
                break;
            case RIGHT:
                moveX = 1;
                break;
        }

        moveX *= STATIC.gridSize;
        moveY *= STATIC.gridSize;

        new Background().draw();
        boolean xLocked = false;
        for (Tile tile: this.tiles) {
            int newX = tile.x + moveX;
            int newY = tile.y + moveY;

            println("newY", newY);

            if (!this.locked) {
                if (newY >= height) this.locked = true;
                for (Tile lockedTile: lockedTiles) {
                    println("lockedTile.y", lockedTile.y);
                    if (lockedTile.y == newY && lockedTile.x == newX) {
                        this.locked = true;
                        break;
                    }
                }
            }
            if (!xLocked && (newX >= width || newX < 0)) xLocked = true;
        }

        if (this.locked || xLocked) {
            drawTiles();
            return;
        }
        for (Tile tile: this.tiles) {
            int newX = tile.x + moveX;
            int newY = tile.y + moveY;
            tile.setXAndY(newX, newY);
        }
    }

    void rotateTile(Rotation rotation) {
        if (rotation == Rotation.CLOCKWISE) {
            
        }
    }

    void drawTiles() {
        for (Tile tile: this.tiles) {
            tile.printSquare();
        }
    }
}