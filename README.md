# Photo Uploader (Flutter + BLoC)

A prototype photo uploader app for selecting images from the gallery and uploading them to a server.  
Built with **Flutter** and **BLoC (Cubit)** for state management.

---

## Features
- Select up to **5 photos** from the device gallery.
- Sequential upload: photos are uploaded **one by one**.
- Progress indicator (e.g., `2 of 5 photo is uploading...`).
- Each photo has a status:
  - `pending` — waiting to be uploaded
  - `loading` — currently uploading
  - `success` — uploaded successfully
  - `error` — upload failed
- Retry failed uploads only, without restarting the entire queue.
- Upload works **only while the app is active** (no background services required).

---

## How to Run

### 1. Clone the repository
```bash
git clone https://github.com/glabglob/rockwolf_test.git

cd rockwolf_test

``` 

### 2. Install dependencies
```bash
flutter pub get

``` 

### 3. Run the app
```bash
flutter run

``` 

### Chosen Solutions

1. **State Management – BLoC (Cubit)**
   - Cubit is used for simple state management of photo uploads.
   - Handles the upload queue, photo statuses, and progress updates efficiently.

2. **Architecture – Simplified Clean Architecture**
   - Layers:
     - **UI Layer** – displays GridView with photo previews and buttons, reacts to state changes.
     - **Cubit Layer** – manages state and orchestrates business logic.
     - **UseCase Layer** – encapsulates the business logic of uploading a single photo.
     - **Repository Layer** – abstracts the data source, allows easy replacement or mocking.
     - **Service Layer** – low-level implementation for actual file/API upload.

3. **Photo Upload – Sequential**
   - Photos are uploaded one by one to properly track progress and handle errors.

4. **Error Handling**
   - If upload fails (e.g., network disconnect), photo status is set to `error`.
   - "Retry Failed" button re-uploads only failed photos.

5. **Preview & Feedback**
   - Each photo displays a preview and current status (`pending`, `loading`, `success`, `error`).
   - Shows upload progress: `2 of 5 photo is uploading...`.

6. **No Background Upload**
   - Upload works only while the app is active, simplifying architecture and avoiding background service complexity.
