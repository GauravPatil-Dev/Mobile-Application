import 'package:flutter/material.dart';
import '../models/cards.dart'; // Import the CardData model

class CardScreen extends StatefulWidget {
  final List<CardData> flashcards;

  CardScreen({required this.flashcards});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int currentIndex = 0;
  bool isFlipped = false;
  int seenCount = 1;
  int peekedCount = 0;
  Set<int> seenIndices = Set();
  Set<int> peekedIndices = Set();

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.flashcards.length;
      isFlipped = false;
      if (!seenIndices.contains(currentIndex)) {
        seenCount++;
        seenIndices.add(currentIndex);
      }
    });
  }

  void prevCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.flashcards.length) %
          widget.flashcards.length;
      isFlipped = false;
      if (!seenIndices.contains(currentIndex)) {
        seenCount++;
        seenIndices.add(currentIndex);
      }
    });
  }

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
      if (isFlipped && !peekedIndices.contains(currentIndex)) {
        peekedCount++;
        peekedIndices.add(currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final flashcard = widget.flashcards[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Viewer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: flipCard,
            child: Card(
              color: isFlipped ? Colors.green : Colors.red,
              child: Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          isFlipped ? 'Answer' : 'Question',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        isFlipped ? flashcard.answer : flashcard.question,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: prevCard,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: nextCard,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Seen: $seenCount / ${widget.flashcards.length}'),
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: flipCard,
              ),
              Text('Peeked: $peekedCount / $seenCount'),
            ],
          ),
        ),
      ),
    );
  }
}
