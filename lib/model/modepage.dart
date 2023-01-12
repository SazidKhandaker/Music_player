

import 'dart:convert';

Modelclass? modelclassFromJson(String str) => Modelclass.fromJson(json.decode(str));

String modelclassToJson(Modelclass? data) => json.encode(data!.toJson());

class Modelclass {
    Modelclass({
        this.data,
        this.success,
        this.status,
    });

    List<Datum?>? data;
    bool? success;
    int? status;

    factory Modelclass.fromJson(Map<String, dynamic> json) => Modelclass(
        data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "success": success,
        "status": status,
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.coverArt,
        this.file,
        this.artistId,
        this.genreId,
        this.listens,
        this.isFeatured,
        this.description,
    });

    int? id;
    String? name;
    String? coverArt;
    String? file;
    int? artistId;
    int? genreId;
    int? listens;
    int? isFeatured;
    String? description;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        coverArt: json["cover_art"],
        file: json["file"],
        artistId: json["artist_id"],
        genreId: json["genre_id"],
        listens: json["listens"],
        isFeatured: json["is_featured"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover_art": coverArt,
        "file": file,
        "artist_id": artistId,
        "genre_id": genreId,
        "listens": listens,
        "is_featured": isFeatured,
        "description": description,
    };
}
