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

**Create comprehensive tests following the Test Pyramid:**

**Step 7.1: Unit Tests (Domain Layer)**
```dart
// test/features/[feature]/domain/usecases/get_products_test.dart
void main() {
  late GetProducts usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProducts(mockRepository);
  });

  group('GetProducts', () {
    final tProducts = [
      Product(id: 1, name: 'Test Product', price: 99.99, description: 'Test'),
    ];

    test('should get products from repository', () async {
      // arrange
      when(() => mockRepository.getProducts())
          .thenAnswer((_) async => Right(tProducts));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tProducts));
      verify(() => mockRepository.getProducts());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure('Server Error');
      when(() => mockRepository.getProducts())
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase();

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
```

**Step 7.2: Unit Tests (Data Layer)**
```dart
// test/features/[feature]/data/repositories/product_repository_impl_test.dart
void main() {
  late ProductRepositoryImpl repository;
  late MockProductApiService mockApiService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockApiService = MockProductApiService();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      apiService: mockApiService,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getProducts', () {
    final tProductModels = [
      ProductModel(id: 1, name: 'Test Product', price: 99.99, description: 'Test'),
    ];

    test('should return products when network is connected', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApiService.getProducts())
          .thenAnswer((_) async => tProductModels);

      // act
      final result = await repository.getProducts();

      // assert
      verify(() => mockNetworkInfo.isConnected);
      verify(() => mockApiService.getProducts());
      expect(result, Right(tProductModels));
    });

    test('should return network failure when no internet', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.getProducts();

      // assert
      verify(() => mockNetworkInfo.isConnected);
      expect(result, const Left(NetworkFailure('No internet connection')));
    });

    test('should return server failure when api throws ServerException', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApiService.getProducts())
          .thenThrow(const ServerException('Server Error'));

      // act
      final result = await repository.getProducts();

      // assert
      expect(result, const Left(ServerFailure('Server Error')));
    });
  });
}
```

**Step 7.3: BLoC Tests (Presentation Layer)**
```dart
// test/features/[feature]/presentation/bloc/product_bloc_test.dart
void main() {
  late ProductBloc bloc;
  late MockGetProducts mockGetProducts;

  setUp(() {
    mockGetProducts = MockGetProducts();
    bloc = ProductBloc(getProducts: mockGetProducts);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be ProductInitial', () {
    expect(bloc.state, ProductInitial());
  });

  group('GetProductsEvent', () {
    final tProducts = [
      Product(id: 1, name: 'Test Product', price: 99.99, description: 'Test'),
    ];

    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetProducts())
            .thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductsEvent()),
      expect: () => [
        ProductLoading(),
        ProductLoaded(tProducts),
      ],
      verify: (_) {
        verify(() => mockGetProducts());
      },
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductError] when getting data fails',
      build: () {
        when(() => mockGetProducts())
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductsEvent()),
      expect: () => [
        ProductLoading(),
        const ProductError('Server Error'),
      ],
    );
  });
}
```

**Step 7.4: Widget Tests**
```dart
// test/features/[feature]/presentation/pages/product_page_test.dart
void main() {
  late MockProductBloc mockBloc;

  setUp(() {
    mockBloc = MockProductBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockBloc,
        child: const ProductPage(),
      ),
    );
  }

  group('ProductPage', () {
    testWidgets('should show loading indicator when state is ProductLoading',
        (tester) async {
      // arrange
      when(() => mockBloc.state).thenReturn(ProductLoading());
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show products list when state is ProductLoaded',
        (tester) async {
      // arrange
      final products = [
        Product(id: 1, name: 'Test Product', price: 99.99, description: 'Test'),
      ];
      when(() => mockBloc.state).thenReturn(ProductLoaded(products));
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
    });

    testWidgets('should show error message when state is ProductError',
        (tester) async {
      // arrange
      when(() => mockBloc.state).thenReturn(const ProductError('Error message'));
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Error: Error message'), findsOneWidget);
    });
  });
}
```

**Step 7.5: Integration Tests**
```dart
// integration_test/features/product/product_flow_test.dart
void main() {
  group('Product Feature Integration Tests', () {
    testWidgets('complete product flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to products page
      await tester.tap(find.byIcon(Icons.shopping_bag));
      await tester.pumpAndSettle();

      // Verify products page is displayed
      expect(find.text('Products'), findsOneWidget);

      // Wait for products to load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify products are displayed
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
```

**Step 7.6: Mock Classes**
```dart
// test/helpers/test_helper.dart
import 'package:mocktail/mocktail.dart';

// Domain mocks
class MockProductRepository extends Mock implements ProductRepository {}
class MockGetProducts extends Mock implements GetProducts {}

// Data mocks
class MockProductApiService extends Mock implements ProductApiService {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

// Presentation mocks
class MockProductBloc extends MockBloc<ProductEvent, ProductState> 
    implements ProductBloc {}

// Test data
class ProductTestData {
  static const tProduct = Product(
    id: 1,
    name: 'Test Product',
    price: 99.99,
    description: 'Test Description',
  );

  static const tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 99.99,
    description: 'Test Description',
  );

  static final tProductsList = [tProduct];
  static final tProductModelsList = [tProductModel];
}
```

### 🏗️ **Testing Strategy & Best Practices**

#### **Test Pyramid Structure**
```
              ┌─────────────────┐
              │ Integration (E2E)│  ← Few, Slow, Expensive
              │     Tests       │
              └─────────────────┘
           ┌──────────────────────┐
           │   Widget/UI Tests    │  ← Some, Medium Speed
           │  (Component Tests)   │
           └──────────────────────┘
      ┌─────────────────────────────┐
      │        Unit Tests           │  ← Many, Fast, Cheap
      │ (Business Logic & Data)     │
      └─────────────────────────────┘
```

#### **Testing Commands**
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run only unit tests
flutter test test/features/

# Run only widget tests
flutter test test/features/*/presentation/

# Run integration tests
flutter test integration_test/

# Run specific test file
flutter test test/features/user/domain/usecases/get_current_user_test.dart

# Run tests in watch mode (during development)
flutter test --watch

# Generate coverage report (HTML)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

#### **Test File Organization**
```
test/
├── features/
│   └── [feature_name]/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── [entity]_api_service_impl_test.dart
│       │   ├── models/
│       │   │   └── [entity]_model_test.dart
│       │   └── repositories/
│       │       └── [entity]_repository_impl_test.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── [entity]_test.dart
│       │   └── usecases/
│       │       └── get_[entity]_test.dart
│       └── presentation/
│           ├── bloc/
│           │   └── [entity]_bloc_test.dart
│           ├── pages/
│           │   └── [entity]_page_test.dart
│           └── widgets/
│               └── [entity]_widget_test.dart
├── helpers/
│   ├── test_helper.dart        # Mock classes & test data
│   └── pump_app.dart          # Widget test helpers
└── fixtures/
    └── [entity]_fixture.json  # Test JSON data

integration_test/
├── features/
│   └── [feature_name]/
│       └── [entity]_flow_test.dart
└── app_test.dart              # Main app integration tests
```

#### **Testing Guidelines**

**✅ DO:**
- Write tests for all business logic (use cases)
- Test both success and failure scenarios
- Mock external dependencies (API, database)
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Test edge cases and error conditions
- Keep tests isolated and independent

**❌ DON'T:**
- Test implementation details
- Write tests that depend on other tests
- Mock what you own (avoid mocking your own classes)
- Test getters/setters without logic
- Write overly complex tests

#### **Test Coverage Goals**
- **Domain Layer**: 100% (pure business logic)
- **Data Layer**: 90%+ (critical data handling)
- **Presentation Layer**: 80%+ (UI logic & state management)
- **Overall Project**: 85%+

#### **Useful Test Extensions**
```dart
// test/helpers/test_extensions.dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
      ),
    );
  }
}

extension BlocTestHelper on WidgetTester {
  Future<void> pumpBlocProvider<B extends BlocBase<S>, S>(
    B bloc,
    Widget child,
  ) {
    return pumpApp(
      BlocProvider<B>.value(
        value: bloc,
        child: child,
      ),
    );
  }
}
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