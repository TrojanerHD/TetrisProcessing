class Tile {
    int[] tileColor;
    int x;
    int y;

    Tile(int x, int y, int[] tileColor) {
        this.x = x * STATIC.gridSize;
        this.y = y * STATIC.gridSize;
        this.tileColor = tileColor; 

        this.printSquare();
    }

    void setXAndY(int x, int y) {
        this.x = x;
        this.y = y;
        drawEverything();
    }

    void printSquare() {
        fill(color(tileColor[0], tileColor[1], tileColor[2]));
        square(this.x, this.y, STATIC.gridSize);
    }
}