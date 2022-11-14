import 'package:flutter/material.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/ticket.dart';

class TicketTesting extends StatefulWidget {
  const TicketTesting({super.key});

  @override
  State<TicketTesting> createState() => _TicketTestingState();
}

class _TicketTestingState extends State<TicketTesting> {
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<Ticket>> _apiResponse;

  Future<APIResponse<List<Ticket>>> getAllTickets() async {
    return _apiResponse = await resService.getTicketList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getAllTickets(),
        builder: (BuildContext context,
            AsyncSnapshot<APIResponse<List<Ticket>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final ticket = snapshot.data!;
          return ListView.builder(
              itemCount: ticket.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => ProductsByCategoryScreen(
                    //       categoryName: snapshot.data!.data![index],
                    //     ),
                    //   ),
                    // ),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          ticket.data![index].status,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Ticket ticket = Ticket(
            assignee: "flutter5",
            status: "flutter pending5",
            subject: "tesst",
            description: "test",
            tracker: "test",
          );
          final result = await resService.createTicket(ticket);
          setState(() {
            getAllTickets();
          });
          print(result.error);
        },
      ),
    );
  }
}
