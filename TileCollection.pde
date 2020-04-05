class TileCollection {
    ArrayList<Tile> tiles = new ArrayList<Tile>();
    boolean locked = false;

    void generateRandomTile() {
        switch (Math.round(random(1f))) {
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

            if (newY >= height) this.locked = true;
            if (newX >= width || newX < 0) xLocked = true;
        }

        //TODO When multiple blocks, everything will go to the ground instead of 
        //stop even when there is a tile underneath it
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