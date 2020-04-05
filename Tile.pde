class Tile {
    private color tileColor;
    int x;
    int y;

    Tile(int x, int y, int[] tileColor) {
        this.x = x * STATIC.gridSize;
        this.y = y * STATIC.gridSize;
        this.tileColor = color(tileColor[0], tileColor[1], tileColor[2]);

        this.printSquare();
    }

    void setXAndY(int x, int y) {
        this.x = x;
        this.y = y;
        this.printSquare();
    }

    void printSquare() {
        fill(this.tileColor);
        square(this.x, this.y, STATIC.gridSize);
    }
}