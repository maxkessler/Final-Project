class Hue {
  
  int extractColorFromImage() {
    frame.loadPixels();
    int numberOfPixels = frame.pixels.length;
    int[] huesArray = new int[hueRange];
    float[] saturations = new float[hueRange];
    float[] brightnesses = new float[hueRange];

    for (int i = 0; i < numberOfPixels; i++) {
      int pixel = frame.pixels[i];
      int hueVal = Math.round(hue(pixel));
      float saturation = saturation(pixel);
      float brightness = brightness(pixel);
      huesArray[hueVal]++;
      saturations[hueVal] += saturation;
      brightnesses[hueVal] += brightness;
    }
    // Find the most common hue.
    int hueCount = huesArray[0];
    int hue = 0;
    for (int i = 1; i < huesArray.length; i++) {
       if (huesArray[i] > hueCount) {
        hueCount = huesArray[i];
        hue = i;
      }
    }
    println("The max hue is: ",hue);

    this.hue = hue;

    brightness = brightnesses[hue] / hueCount;

    return hue;

  }
  
}
