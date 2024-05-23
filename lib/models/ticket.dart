// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ticket {
  // ignore: non_constant_identifier_names
  final int? ticket_id;
  final String assignee;
  final String status;
  final String subject;
  final String description;
  final String tracker;
  Ticket({
    // ignore: non_constant_identifier_names
    this.ticket_id,
    required this.assignee,
    required this.status,
    required this.subject,
    required this.description,
    required this.tracker,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        ticket_id: json['ticket_id'] as int,
        assignee: json['assignee'] as String,
        status: json['status'] as String,
        subject: json['subject'] as String,
        description: json['description'] as String,
        tracker: json['tracker'] as String,
      );
  Map<String, dynamic> toJson() {
    return {
      'ticket_id': ticket_id,
      'assignee': assignee,
      'status': status,
      'subject': subject,
      'description': description,
      'tracker': tracker,
    };
  }
}
