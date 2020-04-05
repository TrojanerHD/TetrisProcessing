class Background {
    private int x = 0;
    private int y = 0;

    void draw() {
        background(0);
        while (x < width) {
            stroke(255);
            line(x, 0, x, height);
            x += STATIC.gridSize;
        }

        while (y < height) {
            line(0, y, width, y);
            y += STATIC.gridSize;
        }
    }

}
