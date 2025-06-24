# Flutter Base Project - Clean Architecture

## Project Structure

This project follows Clean Architecture principles with the following layer structure:

```
lib/
├── core/                          # Core functionality
│   ├── di/                        # Dependency Injection
│   ├── error/                     # Error handling
│   ├── network/                   # Network configurations
│   ├── router/                    # Navigation routing
│   └── usecase/                   # Base use case classes
├── features/                      # Feature modules
│   └── user/                      # User feature example
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Data sources (API, local)
│       │   ├── models/            # Data models
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Business logic
│       └── presentation/          # Presentation layer
│           ├── bloc/              # BLoC state management
│           ├── pages/             # UI pages
│           └── widgets/           # Reusable widgets
├── flavors.dart                   # App flavors configuration
├── main.dart                      # Main entry point
├── main_develop.dart              # Development entry point
├── main_staging.dart              # Staging entry point
└── main_production.dart           # Production entry point
```

## Architecture Layers

### 1. Presentation Layer
- **BLoC**: State management using flutter_bloc
- **Pages**: UI screens and pages
- **Widgets**: Reusable UI components

### 2. Domain Layer
- **Entities**: Core business objects
- **Use Cases**: Business logic operations
- **Repositories**: Abstract interfaces for data operations

### 3. Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: API services and local storage
- **Repository Implementations**: Concrete implementations of domain repositories

## Key Technologies

### State Management
- **flutter_bloc**: For predictable state management
- **equatable**: For value equality without boilerplate

### Networking
- **dio**: HTTP client for API calls
- **retrofit**: Type-safe REST client generator
- **pretty_dio_logger**: Logging for network requests

### Navigation
- **go_router**: Declarative routing solution

### Code Generation
- **json_annotation**: JSON serialization annotations
- **build_runner**: Code generation tool
- **injectable**: Dependency injection code generation

### Development Tools
- **freezed**: Code generation for data classes
- **bloc_test**: Testing utilities for BLoC
- **mocktail**: Mocking library for tests

## App Flavors

The project supports three flavors:
- **Development**: For development environment
- **Staging**: For testing environment  
- **Production**: For production environment

Each flavor has:
- Different app names and bundle IDs
- Different API endpoints
- Different configurations

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code:
```bash
flutter packages pub run build_runner build
```

3. Run the app with desired flavor:
```bash
# Development
flutter run --flavor develop -t lib/main_develop.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor production -t lib/main_production.dart
```

## VSCode Configuration

The project includes VSCode launch configurations for debugging all flavors in different modes (debug, profile, release).

## Testing

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for full user flows

Run tests with:
```bash
flutter test
```

## Feature Development Guide

### Step-by-Step Process for Creating a New Feature

#### 1. 🏗️ **Plan Your Feature**
```
Define:
- Feature name (e.g., "product", "order", "notification")
- Required entities and their properties
- API endpoints needed
- User flows and screens
```

#### 2. 📁 **Create Feature Structure**
```bash
lib/features/[feature_name]/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

#### 3. 🎯 **Domain Layer First (Inside-Out Approach)**

**Step 3.1: Create Entity**
```dart
// lib/features/[feature]/domain/entities/[entity].dart
class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final String description;
  
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
  
  @override
  List<Object> get props => [id, name, price, description];
}
```

**Step 3.2: Create Repository Interface**
```dart
// lib/features/[feature]/domain/repositories/[entity]_repository.dart
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, Product>> createProduct(Product product);
}
```

**Step 3.3: Create Use Cases**
```dart
// lib/features/[feature]/domain/usecases/get_products.dart
@injectable
class GetProducts extends UseCaseNoParams<List<Product>> {
  final ProductRepository repository;
  
  GetProducts(this.repository);
  
  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
```

#### 4. 💾 **Data Layer**

**Step 4.1: Create Model with JSON Serialization**
```dart
// lib/features/[feature]/data/models/[entity]_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/[entity].dart';

part '[entity]_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
```

**Step 4.2: Create API Service**
```dart
// lib/features/[feature]/data/datasources/[entity]_api_service_impl.dart
@LazySingleton(as: ProductApiService)
class ProductApiServiceImpl implements ProductApiService {
  final DioClient _dioClient;
  
  ProductApiServiceImpl(this._dioClient);
  
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dioClient.client.get('/products');
    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
```

**Step 4.3: Create Repository Implementation**
```dart
// lib/features/[feature]/data/repositories/[entity]_repository_impl.dart
@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService apiService;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await apiService.getProducts();
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
```

#### 5. 🎨 **Presentation Layer**

**Step 5.1: Create BLoC Events & States**
```dart
// lib/features/[feature]/presentation/bloc/[entity]_bloc.dart
// Events
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductEvent {}

// States  
abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

// BLoC
@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  
  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
  }
  
  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
```

**Step 5.2: Create UI Pages**
```dart
// lib/features/[feature]/presentation/pages/[entity]_page.dart
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductBloc>()..add(GetProductsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
```

#### 6. 🔧 **Integration Steps**

**Step 6.1: Add API Endpoints**
```dart
// lib/core/network/api_endpoints.dart
class ApiEndpoints {
  static const String products = '/products';
  static const String productById = '/products/{id}';
}
```

**Step 6.2: Run Code Generation**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Step 6.3: Add Route (if needed)**
```dart
// lib/core/router/app_router.dart
GoRoute(
  path: '/products',
  name: 'products',
  builder: (context, state) => const ProductPage(),
),
```

**Step 6.4: Add to Bottom Navigation (if needed)**
```dart
// lib/root/presentation/widgets/bottom_nav_item.dart
BottomNavItem(
  icon: Icons.shopping_bag_outlined,
  activeIcon: Icons.shopping_bag,
  labelKey: 'products',
),
```

#### 7. 🧪 **Testing**

**Create tests for each layer:**
```dart
// test/features/[feature]/domain/usecases/get_products_test.dart
// test/features/[feature]/data/repositories/product_repository_impl_test.dart
// test/features/[feature]/presentation/bloc/product_bloc_test.dart
```

#### 8. 📱 **Add Localization**
```json
// lib/l10n/app_en.arb
{
  "products": "Products",
  "productName": "Product Name",
  "productPrice": "Price"
}
```

### 🎯 **Development Order Summary**

1. **Domain** → Entities → Repository Interface → Use Cases
2. **Data** → Models → API Service → Repository Implementation  
3. **Presentation** → BLoC → Pages → Widgets
4. **Integration** → Routes → Navigation → Localization
5. **Testing** → Unit → Widget → Integration

### 🔄 **Code Generation Commands**

```bash
# Generate all code
dart run build_runner build --delete-conflicting-outputs

# Watch for changes (development)
dart run build_runner watch --delete-conflicting-outputs

# Generate localization
flutter gen-l10n
```

### 📝 **Checklist for New Feature**

- [ ] Domain entities created
- [ ] Repository interface defined
- [ ] Use cases implemented
- [ ] Data models with JSON serialization
- [ ] API service created
- [ ] Repository implementation done
- [ ] BLoC events/states/logic
- [ ] UI pages and widgets
- [ ] Routes added (if needed)
- [ ] Localization keys added
- [ ] Code generation run
- [ ] Tests written
- [ ] Documentation updated

## Best Practices

1. **Separation of Concerns**: Each layer has specific responsibilities
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Single Responsibility**: Each class has one reason to change
4. **Testability**: Architecture supports easy unit testing
5. **Code Generation**: Reduces boilerplate and maintains consistency 