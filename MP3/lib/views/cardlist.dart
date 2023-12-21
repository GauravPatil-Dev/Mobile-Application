import 'package:flutter/material.dart';
import 'package:mp3/views/cardSeen.dart';
import 'editCardScreen.dart';
import '../utils/dbHelper.dart';
import '../models/cards.dart';

class CardList extends StatefulWidget {
  final List<CardData> flashcards;
  final int deckId;
  final VoidCallback onCardsUpdated;

  const CardList(
      {Key? key,
      required this.deckId,
      required this.flashcards,
      required this.onCardsUpdated})
      : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<CardData> originalOrder = [];
  List<CardData> sortedOrder = [];
  bool isSorted = false;

  _CardListState();

  @override
  void initState() {
    super.initState();
    originalOrder = List.from(widget.flashcards);
  }

  void editItem(int index, CardData updatedFlashcard) {
    dbHelper.editCard(updatedFlashcard).then((_) {
      setState(() {
        originalOrder[index] = updatedFlashcard;
        var sortedIndex = sortedOrder.indexOf(originalOrder[index]);

        sortedOrder[sortedIndex] = updatedFlashcard;
      });
      widget.onCardsUpdated(); // Update the parent widget
    });
  }

  void addCard(CardData newCard) {
    dbHelper.insertCard(newCard).then((_) {
      setState(() {
        originalOrder
            .add(newCard); // Update the originalOrder list with the new card

        // If the list is sorted, update the sortedOrder list as well
        sortedOrder = List.from(originalOrder)
          ..sort((a, b) => a.question.compareTo(b.question));
      });
      widget.onCardsUpdated(); // Update the parent widget
    });
  }

  void deleteCard(int index) {
    int idToDelete = isSorted ? sortedOrder[index].id : originalOrder[index].id;
    widget.flashcards.removeAt(index);
    dbHelper.deleteCard(idToDelete).then((_) {
      setState(() {
        originalOrder.removeWhere((card) => card.id == idToDelete);
        sortedOrder.removeWhere((card) => card.id == idToDelete);
        // update the sortedOrder list as well
        sortedOrder = List.from(originalOrder)
          ..sort((a, b) => a.question.compareTo(b.question));
      });
    });
    reloadCardData();
    widget.onCardsUpdated(); // call the callback here
  }

  void sortFlashcards() {
    setState(() {
      if (isSorted) {
        isSorted = false;
      } else {
        if (sortedOrder.isEmpty) {
          sortedOrder = List.from(originalOrder)
            ..sort((a, b) => a.question.compareTo(b.question));
        }
        isSorted = true;
      }
    });
  }

  void reloadCardData() async {
    final dbCards = await dbHelper.fetchCards(
        widget.deckId); // assuming widget.deckId is the id of the current deck
    if (dbCards != null) {
      setState(() {
        originalOrder =
            dbCards.map((cardMap) => CardData.fromMap(cardMap)).toList();

        sortedOrder = List.from(originalOrder)
          ..sort((a, b) => a.question.compareTo(b.question));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int columnsCount = MediaQuery.of(context).size.width ~/ 150;
    List<CardData> currentView = isSorted ? sortedOrder : originalOrder;

    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: sortFlashcards,
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardScreen(flashcards: widget.flashcards),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnsCount,
        ),
        itemCount: currentView.length,
        padding: const EdgeInsets.all(3),
        itemBuilder: (context, index) {
          final flashcard = currentView[index];
          final question = flashcard.question;

          return Card(
            color: Colors.purple[100],
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCardScreen(
                            flashcard: flashcard,
                            onSave: (updatedFlashcard) =>
                                editItem(index, updatedFlashcard),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(child: Text('$question')),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteCard(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCardScreen(
                                flashcard: flashcard,
                                onSave: (updatedFlashcard) =>
                                    editItem(index, updatedFlashcard),
                              ),
                            ),
                          );
                        },
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newCard = CardData(
            id: 0, // Assume ID is auto-generated by the database
            deckId: widget.deckId, // Provide the deckId here,
            question: 'New Question',
            answer: 'New Answer',
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCardScreen(
                flashcard: newCard,
                onSave: (updatedFlashcard) => addCard(updatedFlashcard),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
