import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  final Function(int) listener;
  final int totalPage;
  final int threshold;
  final int currentPage;

  const NumberPagination({
    required this.listener,
    required this.totalPage,
    this.threshold = 5,
    this.currentPage = 1,
    Key? key,
  }) : super(key: key);

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int currentPage;
  late int rangeStart;
  late int rangeEnd;

  @override
  void initState() {
    currentPage = widget.currentPage;
    _rangeSet();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentPage = widget.currentPage;
    _rangeSet();
    setState(() {});
  }

  void changePage(int page) {
    if (page <= 0) page = 1;

    if (page > widget.totalPage) page = widget.totalPage;

    setState(() {
      currentPage = page;
      _rangeSet();
      widget.listener(currentPage);
    });
  }

  void _rangeSet() {
    rangeStart = currentPage % widget.threshold == 0
        ? currentPage - widget.threshold
        : (currentPage ~/ widget.threshold) * widget.threshold;

    rangeEnd = rangeStart + widget.threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => changePage(0),
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(
                Icons.first_page,
                size: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => changePage(--currentPage),
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ...List.generate(
            rangeEnd <= widget.totalPage
                ? widget.threshold
                : widget.totalPage % widget.threshold,
            (index) => Flexible(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => changePage(index + 1 + rangeStart),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    color: (currentPage - 1) % widget.threshold == index
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Text(
                    '${index + 1 + rangeStart}',
                    style: TextStyle(
                      color: (currentPage - 1) % widget.threshold == index
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => changePage(++currentPage),
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => changePage(widget.totalPage),
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(
                Icons.last_page,
                size: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
