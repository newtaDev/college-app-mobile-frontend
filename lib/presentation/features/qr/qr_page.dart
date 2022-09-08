import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/double_circular_border.dart';

import '../../../shared/global/constants.dart';

class QrPage extends StatelessWidget {
  const QrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Profile QR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DoubleCircularBorder(
                        size: size.width * 0.7 > 400 ? 400 : size.width * 0.7,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(
                                  'iVBORw0KGgoAAAANSUhEUgAAAHQAAAB0CAYAAABUmhYnAAAAAklEQVR4AewaftIAAAKzSURBVO3BQQ7kRgwEwSxC//9y2kf60oAgabxLMCL+izVGsUYp1ijFGqVYoxRrlGKNUqxRijVKsUYp1ijFGqVYoxRrlGKNUqxRLh5Kwi+pPJGETuUkCb+k8kSxRinWKMUa5eJlKm9Kwh1J6FQ6lSdU3pSENxVrlGKNUqxRLj6WhDtU7khCp9IloVPpktCp3JGEO1S+VKxRijVKsUa5GE6lS0KnMkmxRinWKMUa5WKYJNyRhE7lb1asUYo1SrFGufiYyi+pdEnoVLokPKHyJynWKMUapVijXLwsCZMl4U9WrFGKNUqxRrl4SOVvkoQ7VP4mxRqlWKMUa5SLh5LQqXRJeJNKp9Il4USlS8JJEt6k8qVijVKsUYo1ysXHVO5IQqdykoRO5U0qJ0noVLoknCShU3miWKMUa5RijXLxsSScqJwk4UTljiR0Kl0STlQ6lROVE5U3FWuUYo1SrFEuHlI5UemScIdKl4STJJyo3KHSJeFLKk8Ua5RijVKsUS4+loRO5Y4kdCpdEjqVLgldEjqVTqVLwolKl4RO5SQJbyrWKMUapVijXHxM5Q6VL6l0SThR6ZLQJaFT6ZLwS8UapVijFGuUi4eS8EsqncqJyh0qd6h0SehUuiR0Km8q1ijFGqVYo1y8TOVNSThJwolKl4STJHQqJ0k4SUKn8qVijVKsUYo1ysXHknCHyhMqXRJOVLokdEm4Q+UkCScqTxRrlGKNUqxRLtZ/qNyRhC4JJypfKtYoxRqlWKNcDJOETqVLQpeEJ1ROkvBLxRqlWKMUa5SLj6l8SeUOlSeS0CWhU/k/FWuUYo1SrFEuXpaEX0rCHSpdEjqVLgknKicqXRI6lTcVa5RijVKsUeK/WGMUa5RijVKsUYo1SrFGKdYoxRqlWKMUa5RijVKsUYo1SrFGKdYoxRrlH+aJCvpm+78XAAAAAElFTkSuQmCC',
                                ),
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Newton Michael',
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      'Reg No: 191962707',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.qr_code_scanner_sharp),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorsPallet.grey),
              ),
              label: const Text('Scan qr code'),
            ),
          ),
        ],
      ),
    );
  }
}
