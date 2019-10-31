import 'dart:math';
import 'dart:ui';

import 'package:findpairs/Models/Painters/ParticleModel.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class Particles{

  List<ParticleModel> _particles;
  
  List<ParticleModel> get particles => _particles;

  Particles.generate({
    int totalParticle,
    List<Color> particleColors,
    double width,
    double height
  }){
    Random random = Random();
    _particles = List<ParticleModel>.generate(totalParticle, (particleModel){
      return ParticleModel(
        color: particleColors[random.nextInt(particleColors.length)],
        left: random.nextInt((width - 10).toInt()).toDouble(),// minus by padding 5 in horizontal,
        top: random.nextInt((width - 10).toInt()).toDouble(),// minus by let particle fall in 10,
        sizeFactor: (random.nextInt(1000))/1000,
        type: ExplodeType.Drop
      );
    }).toList();
  }
}