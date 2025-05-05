// ignore_for_file: unused_element

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_event.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_state.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/imageRepository.dart';
import 'package:myparkingappadmin/repository/parkingLotRepository.dart';


class  ParkingLotBloc extends Bloc< ParkingLotEvent, ParkingLotState>{
   ParkingLotBloc():super(ParkingLotInitial()){
      on<GetParkingLotByOwnerEvent>(_getParkingLotByOwner);
      on<UpdateStatusParkingLot>(_updateStatusParkingLot);
      on<UpdateParkingLotEvent>(_updateParkingLot);
   }
   void _getParkingLotByOwner(GetParkingLotByOwnerEvent event, Emitter<ParkingLotState> emit) async{
     try{
       emit(ParkingLotLoadingState());
       ParkingLotRepository parkingLotRepository = ParkingLotRepository();
       // Call repository method to get parking lot by owner
       final response = await parkingLotRepository.getParkingLotByOwner(event.userId);
       if(response.code == 200){
         emit(ParkingLotLoadedState(response.result));
       }else{
         emit(ParkingLotErrorState(response.message));
       }
     }catch(e){
       throw Exception("ParkingLotBloc  $e");
     }
   }
   void _updateStatusParkingLot(UpdateStatusParkingLot event, Emitter<ParkingLotState> emit) async{
     try{
       ParkingLotRepository parkingLotRepository = ParkingLotRepository();
       final response = await parkingLotRepository.updateStatusParkingLot(event.newStatus, event.parkingLotId);
       if(response.code == 200){
         emit(ParkingLotSuccessState(response.message));
       }else{
         emit(ParkingLotErrorState(response.message));
       }
     }catch(e){
       throw Exception("ParkingLotBloc  $e");
     }
   }
    void _updateParkingLot(UpdateParkingLotEvent event, Emitter<ParkingLotState> emit) async{
      try{
        ImageRepository imagerepository = ImageRepository();
        Cloudinary cloudinary = await imagerepository.getApiCloud();
        ParkingLotRepository parkingLotRepository = ParkingLotRepository();
        List<Images> finalImages = event.request.images;
        int i = 1;
          List<Images> imagesDelete = event.deleteImage;
          List<Images> imagesAdd = event.request.images.where((e)=>e.imageBytes != null).toList();
          for(var image in imagesAdd){
            i = i + 1;
            CloudinaryResponse uploadResponse = await
              imagerepository.uploadImage(
              cloudinary,
              image.imageBytes!,
              "myparkingapp/parkinglots",
              image.imageID,
              image.imageID
              );
              if(uploadResponse.isSuccessful){
                Images imageAdding = Images(image.imageID, uploadResponse.url,null);
                finalImages.add(imageAdding);
                emit(ParkingLotUpdateImageState("Successful Upload : $i/ ${imagesAdd.length} image" ));
              }
              else{
                emit(ParkingLotUpdateImageState("Failed Upload : ${image.imageID} image" ));
              }
          }
          for(var image in imagesDelete){
            i = i + 1;
            CloudinaryResponse uploadResponse = await
              imagerepository.deleteImage(cloudinary, image.imageID, image.url!);
            if(uploadResponse.isSuccessful){
                emit(ParkingLotUpdateImageState("Successful Delete : $i/ ${imagesAdd.length} image" ));
            }
            else{
              emit(ParkingLotUpdateImageState("Failed Delete : ${image.imageID} image" ));
            }

          }
          UpdateParkingLotRequest request = UpdateParkingLotRequest(
            parkingLotName: event.request.parkingLotName,
            address: event.request.address,
            latitude: event.request.latitude,
            longitude: event.request.longitude,
            description: event.request.description,
            images: finalImages);
          
        final response = await parkingLotRepository.updateParkingLot(event.parkingLotId, request);
        if(response.code == 200){
          emit(ParkingLotSuccessState(response.message));
        }else{
          emit(ParkingLotErrorState(response.message));
        }
      }catch(e){
        throw Exception("ParkingLotBloc _updateParkingLot $e");
      }
    }

    void _createParkingLot(CreateParkingLotEvent event, Emitter<ParkingLotState> emit) async{
     try{
       ParkingLotRepository parkingLotRepository = ParkingLotRepository();
       // Call repository method to get parking lot by owner
       final response = await parkingLotRepository.createParkingLot(event.request);
       if(response.code == 200){
         emit(ParkingLotLoadedState(response.result));
       }else{
         emit(ParkingLotErrorState(response.message));
       }
     }catch(e){
       throw Exception("ParkingLotBloc _createParkingLot :  $e");
     }
   }
}