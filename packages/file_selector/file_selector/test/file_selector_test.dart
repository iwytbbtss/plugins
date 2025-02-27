// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// TODO(stuartmorgan): https://github.com/flutter/flutter/issues/111906
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:file_selector/file_selector.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late FakeFileSelector fakePlatformImplementation;
  const String initialDirectory = '/home/flutteruser';
  const String confirmButtonText = 'Use this profile picture';
  const String suggestedName = 'suggested_name';
  final List<XTypeGroup> acceptedTypeGroups = <XTypeGroup>[
    // TODO(stuartmorgan): https://github.com/flutter/flutter/issues/111906
    // ignore: prefer_const_constructors
    XTypeGroup(label: 'documents', mimeTypes: <String>[
      'application/msword',
      'application/vnd.openxmlformats-officedocument.wordprocessing',
    ]),
    // TODO(stuartmorgan): https://github.com/flutter/flutter/issues/111906
    // ignore: prefer_const_constructors
    XTypeGroup(label: 'images', extensions: <String>[
      'jpg',
      'png',
    ]),
  ];

  setUp(() {
    fakePlatformImplementation = FakeFileSelector();
    FileSelectorPlatform.instance = fakePlatformImplementation;
  });

  group('openFile', () {
    final XFile expectedFile = XFile('path');

    test('works', () async {
      fakePlatformImplementation
        ..setExpectations(
            initialDirectory: initialDirectory,
            confirmButtonText: confirmButtonText,
            acceptedTypeGroups: acceptedTypeGroups)
        ..setFileResponse(<XFile>[expectedFile]);

      final XFile? file = await openFile(
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
        acceptedTypeGroups: acceptedTypeGroups,
      );

      expect(file, expectedFile);
    });

    test('works with no arguments', () async {
      fakePlatformImplementation.setFileResponse(<XFile>[expectedFile]);

      final XFile? file = await openFile();

      expect(file, expectedFile);
    });

    test('sets the initial directory', () async {
      fakePlatformImplementation
        ..setExpectations(initialDirectory: initialDirectory)
        ..setFileResponse(<XFile>[expectedFile]);

      final XFile? file = await openFile(initialDirectory: initialDirectory);
      expect(file, expectedFile);
    });

    test('sets the button confirmation label', () async {
      fakePlatformImplementation
        ..setExpectations(confirmButtonText: confirmButtonText)
        ..setFileResponse(<XFile>[expectedFile]);

      final XFile? file = await openFile(confirmButtonText: confirmButtonText);
      expect(file, expectedFile);
    });

    test('sets the accepted type groups', () async {
      fakePlatformImplementation
        ..setExpectations(acceptedTypeGroups: acceptedTypeGroups)
        ..setFileResponse(<XFile>[expectedFile]);

      final XFile? file =
          await openFile(acceptedTypeGroups: acceptedTypeGroups);
      expect(file, expectedFile);
    });
  });

  group('openFiles', () {
    final List<XFile> expectedFiles = <XFile>[XFile('path')];

    test('works', () async {
      fakePlatformImplementation
        ..setExpectations(
            initialDirectory: initialDirectory,
            confirmButtonText: confirmButtonText,
            acceptedTypeGroups: acceptedTypeGroups)
        ..setFileResponse(expectedFiles);

      final List<XFile> files = await openFiles(
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
        acceptedTypeGroups: acceptedTypeGroups,
      );

      expect(files, expectedFiles);
    });

    test('works with no arguments', () async {
      fakePlatformImplementation.setFileResponse(expectedFiles);

      final List<XFile> files = await openFiles();

      expect(files, expectedFiles);
    });

    test('sets the initial directory', () async {
      fakePlatformImplementation
        ..setExpectations(initialDirectory: initialDirectory)
        ..setFileResponse(expectedFiles);

      final List<XFile> files =
          await openFiles(initialDirectory: initialDirectory);
      expect(files, expectedFiles);
    });

    test('sets the button confirmation label', () async {
      fakePlatformImplementation
        ..setExpectations(confirmButtonText: confirmButtonText)
        ..setFileResponse(expectedFiles);

      final List<XFile> files =
          await openFiles(confirmButtonText: confirmButtonText);
      expect(files, expectedFiles);
    });

    test('sets the accepted type groups', () async {
      fakePlatformImplementation
        ..setExpectations(acceptedTypeGroups: acceptedTypeGroups)
        ..setFileResponse(expectedFiles);

      final List<XFile> files =
          await openFiles(acceptedTypeGroups: acceptedTypeGroups);
      expect(files, expectedFiles);
    });
  });

  group('getSavePath', () {
    const String expectedSavePath = '/example/path';

    test('works', () async {
      fakePlatformImplementation
        ..setExpectations(
            initialDirectory: initialDirectory,
            confirmButtonText: confirmButtonText,
            acceptedTypeGroups: acceptedTypeGroups,
            suggestedName: suggestedName)
        ..setPathResponse(expectedSavePath);

      final String? savePath = await getSavePath(
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
        acceptedTypeGroups: acceptedTypeGroups,
        suggestedName: suggestedName,
      );

      expect(savePath, expectedSavePath);
    });

    test('works with no arguments', () async {
      fakePlatformImplementation.setPathResponse(expectedSavePath);

      final String? savePath = await getSavePath();
      expect(savePath, expectedSavePath);
    });

    test('sets the initial directory', () async {
      fakePlatformImplementation
        ..setExpectations(initialDirectory: initialDirectory)
        ..setPathResponse(expectedSavePath);

      final String? savePath =
          await getSavePath(initialDirectory: initialDirectory);
      expect(savePath, expectedSavePath);
    });

    test('sets the button confirmation label', () async {
      fakePlatformImplementation
        ..setExpectations(confirmButtonText: confirmButtonText)
        ..setPathResponse(expectedSavePath);

      final String? savePath =
          await getSavePath(confirmButtonText: confirmButtonText);
      expect(savePath, expectedSavePath);
    });

    test('sets the accepted type groups', () async {
      fakePlatformImplementation
        ..setExpectations(acceptedTypeGroups: acceptedTypeGroups)
        ..setPathResponse(expectedSavePath);

      final String? savePath =
          await getSavePath(acceptedTypeGroups: acceptedTypeGroups);
      expect(savePath, expectedSavePath);
    });

    test('sets the suggested name', () async {
      fakePlatformImplementation
        ..setExpectations(suggestedName: suggestedName)
        ..setPathResponse(expectedSavePath);

      final String? savePath = await getSavePath(suggestedName: suggestedName);
      expect(savePath, expectedSavePath);
    });
  });

  group('getDirectoryPath', () {
    const String expectedDirectoryPath = '/example/path';

    test('works', () async {
      fakePlatformImplementation
        ..setExpectations(
            initialDirectory: initialDirectory,
            confirmButtonText: confirmButtonText)
        ..setPathResponse(expectedDirectoryPath);

      final String? directoryPath = await getDirectoryPath(
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
      );

      expect(directoryPath, expectedDirectoryPath);
    });

    test('works with no arguments', () async {
      fakePlatformImplementation.setPathResponse(expectedDirectoryPath);

      final String? directoryPath = await getDirectoryPath();
      expect(directoryPath, expectedDirectoryPath);
    });

    test('sets the initial directory', () async {
      fakePlatformImplementation
        ..setExpectations(initialDirectory: initialDirectory)
        ..setPathResponse(expectedDirectoryPath);

      final String? directoryPath =
          await getDirectoryPath(initialDirectory: initialDirectory);
      expect(directoryPath, expectedDirectoryPath);
    });

    test('sets the button confirmation label', () async {
      fakePlatformImplementation
        ..setExpectations(confirmButtonText: confirmButtonText)
        ..setPathResponse(expectedDirectoryPath);

      final String? directoryPath =
          await getDirectoryPath(confirmButtonText: confirmButtonText);
      expect(directoryPath, expectedDirectoryPath);
    });
  });
}

class FakeFileSelector extends Fake
    with MockPlatformInterfaceMixin
    implements FileSelectorPlatform {
  // Expectations.
  List<XTypeGroup>? acceptedTypeGroups = const <XTypeGroup>[];
  String? initialDirectory;
  String? confirmButtonText;
  String? suggestedName;
  // Return values.
  List<XFile>? files;
  String? path;

  void setExpectations({
    List<XTypeGroup> acceptedTypeGroups = const <XTypeGroup>[],
    String? initialDirectory,
    String? suggestedName,
    String? confirmButtonText,
  }) {
    this.acceptedTypeGroups = acceptedTypeGroups;
    this.initialDirectory = initialDirectory;
    this.suggestedName = suggestedName;
    this.confirmButtonText = confirmButtonText;
  }

  // ignore: use_setters_to_change_properties
  void setFileResponse(List<XFile> files) {
    this.files = files;
  }

  // ignore: use_setters_to_change_properties
  void setPathResponse(String path) {
    this.path = path;
  }

  @override
  Future<XFile?> openFile({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    expect(acceptedTypeGroups, this.acceptedTypeGroups);
    expect(initialDirectory, this.initialDirectory);
    expect(suggestedName, suggestedName);
    return files?[0];
  }

  @override
  Future<List<XFile>> openFiles({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    expect(acceptedTypeGroups, this.acceptedTypeGroups);
    expect(initialDirectory, this.initialDirectory);
    expect(suggestedName, suggestedName);
    return files!;
  }

  @override
  Future<String?> getSavePath({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? suggestedName,
    String? confirmButtonText,
  }) async {
    expect(acceptedTypeGroups, this.acceptedTypeGroups);
    expect(initialDirectory, this.initialDirectory);
    expect(suggestedName, this.suggestedName);
    expect(confirmButtonText, this.confirmButtonText);
    return path;
  }

  @override
  Future<String?> getDirectoryPath({
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    expect(initialDirectory, this.initialDirectory);
    expect(confirmButtonText, this.confirmButtonText);
    return path;
  }
}
