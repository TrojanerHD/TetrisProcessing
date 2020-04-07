class TileCollection {
    ArrayList<Tile> tiles = new ArrayList<Tile>();
    boolean locked = false;
    TileType tileType;

    void generateRandomTile() {
        switch (Math.round(random(6f))) {
            case 0:
                this.tileType = TileType.I;
                for (int y = 0; y < 4; y++)
                    tiles.add(new Tile(0, y, TileColor.LIGHT_BLUE));
                break;
            case 1:
                this.tileType = TileType.L_BLUE;
                for (int y = 0; y < 3; y++) {
                    tiles.add(new Tile(0, y, TileColor.DARK_BLUE));
                    if (y == 2) tiles.add(new Tile(1, y, TileColor.DARK_BLUE));
                }
                break;
            case 2:
                this.tileType = TileType.L_ORANGE;
                for (int y = 0; y < 3; y++) {
                    tiles.add(new Tile(1, y, TileColor.ORANGE));
                    if (y == 2) tiles.add(new Tile(0, y, TileColor.ORANGE));
                }
                break;
            case 3:
                this.tileType = TileType.BRICK;
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++) 
                        tiles.add(new Tile(x, y, TileColor.YELLOW));
                break;
            case 4:
                this.tileType = TileType.S;
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++)
                        tiles.add(new Tile(y != 0 ? x : x + 1, y, TileColor.GREEN));
                break;
            case 5:
                this.tileType = TileType.T;
                for (int y = 0; y < 2; y++)
                    if (y == 0) tiles.add(new Tile(1, y, TileColor.PURPLE));
                    else for (int x = 0; x < 3; x++) tiles.add(new Tile(x, y, TileColor.PURPLE));
                break;
            case 6:
                this.tileType = TileType.Z;
                for (int y = 0; y < 2; y++)
                    for (int x = 0; x < 2; x++)
                        tiles.add(new Tile(y != 0 ? x + 1 : x, y, TileColor.RED));
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

            if (!this.locked) {
                if (newY >= height) this.locked = true;
                for (Tile lockedTile: lockedTiles) 
                    if (lockedTile.y == newY && lockedTile.x == newX) {
                        this.locked = true;
                        break;
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

    void rotateTile(boolean clockwise) {
        Tile anchorTile;
        switch (this.tileType) {
            case L_BLUE:
            case L_ORANGE:
            case Z:
                anchorTile = this.tiles.get(1);
                break;
            case I:
            case T:
                anchorTile = this.tiles.get(2);
                break;
            case S:
                anchorTile = this.tiles.get(3);
                break;
            case BRICK:
                return;
            default:
                return;
        }
        PVector anchor = new PVector(anchorTile.x, anchorTile.y);
        for (Tile tile: this.tiles) {
            tile.x -= anchor.x;
            tile.y -= anchor.y;
            int oldY = tile.y;
            int oldX = tile.x;
            if (clockwise) {
                tile.y = -tile.x;
                tile.x = oldY;
            } else {
                tile.x = -tile.y;
                tile.y = oldX;
            }
            tile.x += anchor.x;
            tile.y += anchor.y;
        }
        drawEverything();
    }

    void drawTiles() {
        for (Tile tile: this.tiles) tile.printSquare();
    }
}