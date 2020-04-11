class Background {
    void draw() {
        background(0);
        stroke(255);
        for (int x = 0; x < 11; x++) {
            int gridX = x * STATIC.gridSize;
            line(gridX, 0, gridX, height);
        }

        for (int y = 0; y < 20; y++) {
            int gridY = y * STATIC.gridSize;
            int maxX = STATIC.gridSize * 10;
            line(0, gridY, maxX, gridY);
        }

        fill(255);
        textSize(30);
        text("NEXT", 11 * STATIC.gridSize, 1.5 * STATIC.gridSize);
    }
}
