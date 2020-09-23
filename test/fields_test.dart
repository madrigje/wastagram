import 'package:flutter_test/flutter_test.dart';
import 'package:wastagram/models/fields.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    final date = DateTime.parse('2020-03-16');
    const url = 'FAKE';
    const total = 1;
    const latitude = '33.4';
    const longitude = '100.1';

    final post = Fields.fromMap({
      'date' : date,
      'photourl' : url,
      'quantity' : total,
      'latitude' : latitude,
      'longitude' : longitude,
    });

    expect(post.date, date);
    expect(post.url, url);
    expect(post.total, total);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });
}
