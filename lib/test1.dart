import 'package:flutter/material.dart';
void main() {
  runApp(
    const MaterialApp(
      home: ExampleDragAndDrop(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
const List<Item> _items = [
  Item(
    name: 'Counter',
    uid: '1',
    imageProvider: NetworkImage(
      'https://www.idfdesign.com/images/reception-hotel-and-bar-counters/'
          'regency-hotel-reception-made-on-measure-bar-furnishing.jpg',
    ),
  ),
  Item(
    name: 'Dining',
    uid: '2',
    imageProvider: NetworkImage(
      'https://images.pexels.com/photos/271696/pexels-photo-271696.jpeg?'
          'auto=compress&cs=tinysrgb&w=600',
    ),
  ),
  Item(
    name: 'Room Management',
    uid: '3',
    imageProvider: NetworkImage(

        'https://www.xotels.com/wp-content/uploads/2023/05/Revenue-Management-Xotels.webp',

    ),
  ),
  Item(
    name: 'Warehouse management',
    uid: '4',
    imageProvider: NetworkImage(
      'https://www.extensiv.com/hubfs/AdobeStock_181658575.jpeg',
    ),
  ),
];
@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});
  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}
class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  final List<employee> _people = [
    employee(
      name: 'Arun',
      imageProvider: const NetworkImage(

        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYN4scLAOk6JcRBGzBZrq9N4zSHo6oOB_'

        'aycIUGb6FlF48fK8XsTr1a6AJZgMuYrduBeY&usqp=CAU',
      ),
    ),
    employee(
      name: 'Tanya',
      imageProvider: const NetworkImage(
        'https://cdn-icons-png.flaticon.com/512/4975/4975693.png',
      ),
    ),
    employee(
      name: 'Lokesh',
      imageProvider: const NetworkImage(
        'https://cdn4.iconfinder.com/data/icons/office-34/256/28-512.png',
      ),
    ),
  ];
  final GlobalKey _draggableKey = GlobalKey();
  void _itemDroppedOnemployeeCart({
    required Item item,
    required employee employee,
  }) {
    setState(() {
      employee.items.add(item);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Hotel Management',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 36,
          color: const Color(0xFF09D5CD),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }
  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [Expanded(child: _buildMenuList()), _buildPeopleRow()],
          ),
        ),
      ],
    );
  }
  Widget _buildMenuList() {
    return ListView.separated(

      padding: const EdgeInsets.all(10),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildMenuItem(item: item);
      },
    );
  }
  Widget _buildMenuItem({required Item item}) {
    return Dismissible(
      key: Key(item.uid),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
// Remove the item when dismissed
        setState(() {
          _items.removeWhere((element) => element.uid == item.uid);
        });
      },
      background: Container(
        color: Colors.grey,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: LongPressDraggable<Item>(
        data: item,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: DraggingListItem(
          dragKey: _draggableKey,
          photoProvider: item.imageProvider,
        ),
        child: MenuListItem(
          name: item.name,
          photoProvider: item.imageProvider,
        ),
      ),
    );
  }
  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(children: _people.map(_buildPersonWithDropZone).toList()),
    );
  }
  Widget _buildPersonWithDropZone(employee employee) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return employeeCart(
              hasItems: employee.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              employee: employee,
            );
          },
          onAcceptWithDetails: (details) {
            _itemDroppedOnemployeeCart(item: details.data, employee: employee);
          },
        ),
      ),

    );
  }
}
class employeeCart extends StatelessWidget {
  const employeeCart({
    super.key,
    required this.employee,
    this.highlighted = false,
    this.hasItems = false,
  });
  final employee;
  final bool highlighted;
  final bool hasItems;
  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black;
    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Image(

                    image: employee.imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                employee.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,

                  fontWeight: hasItems ? FontWeight.normal : FontWeight.bold,

                ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 4),
                    const SizedBox(height: 4),
                    Text(
                      '${employee.items.length} item${employee.items.length != 1 ? 's'
                          : ''}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: textColor,
                        fontSize: 12,

                      ),
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });
  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(image: photoProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,

                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,

                    style: Theme.of(context).textTheme.titleMedium?.copyWith(

                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });
  final GlobalKey dragKey;
  final ImageProvider photoProvider;
  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 200,
          width: 200,
          child: Opacity(
            opacity: 0.70,
            child: Image(image: photoProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
@immutable
class Item {
  const Item({
    required this.name,
    required this.uid,
    required this.imageProvider,
  });
  final String name;
  final String uid;
  final ImageProvider imageProvider;
}
class employee {
  employee({required this.name, required this.imageProvider, List<Item>? items})
      : items = items ?? [];
  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;
}