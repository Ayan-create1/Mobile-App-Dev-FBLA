class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> spaceGradient = [
      Colors.amber[400]!,

      //Colors.deepOrange[800]!,
      Colors.black,
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: spaceGradient,
                  radius: 0.3,
                ),
              ),
            ),
          ),

          //*Paints the Stars
          CustomPaint(
            size: Size.infinite,
            painter: StarPainter(),
          ),

          //*Shows Sun
          Center(
            child: Image.asset(
              'assets/Sun_Edited (1).png',
              width: 200,
              height: 200,
            ),
          ),

          //*Space Words Text
          Positioned(
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/Space Text (2).png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.info),
                color: Colors.white,
                splashRadius: 50.0,
                splashColor: Colors.black,
                iconSize: 50.0,
                onPressed: () {
                  //print("works");
                  iHomePopup(context);
                },
              )),
          //*Shows Saturn - Faded
          Positioned(
            top: 150,
            left: 50,
            child: Image.asset(
              'assets/Saturn.png',
              width: 130,
              height: 130,
            ),
          ),

          //*Shows Earth - faded
          Positioned(
            top: 500,
            left: 140,
            child: Image.asset(
              'assets/Earth.png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Mars - faded
          Positioned(
            top: 460,
            left: 30,
            child: Image.asset(
              'assets/Mars.png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Neptune - faded
          Positioned(
            top: 250,
            right: 30,
            child: Image.asset(
              'assets/Neptune (1).png',
              width: 80,
              height: 80,
            ),
          ),

          //*Shows Mercury - faded
          Positioned(
            top: 400,
            right: 10,
            child: Image.asset(
              'assets/Mercury (1).png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Venus - faded
          Positioned(
            top: 480,
            right: 60,
            child: Image.asset(
              'assets/Venus (1).png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Uranus Real
          Positioned(
            top: 160,
            right: 110,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WordSearchGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Uranian Search.png',
                width: 80,
                height: 80,
              ),
            ),
          ),

          //*Shows Jupiter - Real
          Positioned(
            top: 340,
            left: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DragAndDropGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Jupiter.png',
                width: 110,
                height: 110,
              ),
            ),
          ),
          /*
          Positioned(
            top: 20,
            right: MediaQuery.of(context).size.width / 2 - 90,
            child: ElevatedButton(
              child: Text("Go to Word Search"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordSearchGame(),
                  ),
                );
              },
            ),
          ),
          
          Positioned(
            top: 70,
            right: MediaQuery.of(context).size.width / 2 - 90,
            child: ElevatedButton(
              child: Text("Go to Drag and Drop"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DragAndDropGame(),
                  ),
                );
              },
            ),
          ),
          */
        ],
      ),
    );
  }
}